use integer::{u128s_from_felt252, U128sFromFelt252Result};
use dojo_gems::types::{LevelData};
use starknet::ContractAddress;
use array::{ArrayTrait, SpanTrait, Array};
use core::traits::{Into, TryInto};
use option::OptionTrait;
use serde::Serde;
use debug::PrintTrait;
use dojo::world::{Context, IWorldDispatcher, IWorldDispatcherTrait};

// Just one level for now
fn get_level_data(number: u8) -> LevelData {
    return LevelData {
        number,
        grid_size: 8,
        clear_requirement: array![(1, 10)],
        spawn_types: array![(1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1)],
    };
}

fn get_player_level(world: IWorldDispatcher, player: ContractAddress) -> LevelData {
    let number = *world.entity('Level', (array![player.into()]).span(), 0, 1)[0];
    get_level_data((number).try_into().unwrap())
}

fn get_player_grid(world: IWorldDispatcher, player: ContractAddress) -> Array<u128> {
    let level_data = get_player_level(world, player);
    let mut columns = ArrayTrait::new();
    let mut i: felt252 = 0;
    let grid_size: felt252 = level_data.grid_size.into();
    loop {
        if i == grid_size {
            break;
        }
        let col = world.entity('Column', (array![player.into(), i]).span(), 0, 1);

        columns.append((*col[0]).try_into().unwrap());
        i += 1;
    };

    columns
}

// Generates an array of spawn items by probability
fn probabilistic_spawn_items_array(spawn_types: @Array<(u8, u8)>) -> Array<u8> {
    let mut spawn_items = ArrayTrait::new();
    let mut i = 0;
    // Loop through spawn types
    // spawn_type = ( type_id, probability_weight )
    loop {
        if spawn_types.len() == i {
            break;
        };
        let type_info: (u8, u8) = *spawn_types[i];

        let (type_id, relative_spawn_probability) = type_info;
        let mut j = 0;

        // add type_id probability times
        loop {
            if relative_spawn_probability == j {
                break;
            };
            spawn_items.append(type_id);
            j += 1;
        };
        i += 1;
    };
    spawn_items
}

fn generate_columns(
    grid_size: u8, spawn_types: @Array<u8>, player: ContractAddress, salt: felt252
) -> u128 {
    let mut column = 0_u128;
    let mut j = 0;
    let spawn_types_len = spawn_types.len();

    let mut random = match u128s_from_felt252(pedersen(player.into(), salt)) {
        U128sFromFelt252Result::Narrow(x) => x,
        U128sFromFelt252Result::Wide((_, x)) => x,
    };

    let mut prev_rand = 0;
    let mut prev2_rand = 0;

    // add type_id probability times
    loop {
        if grid_size == j {
            break;
        };

        // pop off random 8 bits
        let rand_u8: u32 = (random % 256).try_into().unwrap();
        random = random / 256;
        let mut rand_index: u32 = rand_u8 % spawn_types_len;

        if prev_rand == rand_index && prev_rand == prev2_rand {
            rand_index = (rand_index + 1) % spawn_types_len;
        }

        prev2_rand = prev_rand;
        prev_rand = rand_index;

        column = column * 256 + (*spawn_types[rand_index]).into();
        j += 1;
    };

    column
}

fn pow(base: u128, mut expo: u32) -> u128 {
    let mut res = 1;
    loop {
        if expo == 0 {
            break;
        };
        res = res * base;
        expo -= 1;
    };
    res
}

// Converts a set of column u128s into a row u128 from row index
fn row_from_columns(mut columns: @Array<u128>, row_index: u32) -> u128 {
    let offset = pow(256, row_index);
    let mut row = ((*columns[0]) / offset) % 256;

    let mut i = 1; // First already added
    loop {
        if i == columns.len() {
            break;
        };
        let item = (*columns[i]) / offset % 256;
        row = row * 256 + item;
        i += 1;
    };
    row
}

fn row_matches(mut columns: @Array<u128>, row_index: u32) -> (u32, u32) {
    let column = row_from_columns(columns, row_index);
    column_matches(column)
}

fn column_matches(mut column: u128,) -> (u32, u32) {
    let mut prev2 = column % 256;
    column = column / 256;
    let mut prev = column % 256;
    let mut i = 2;
    let mut match_start = 0xff;
    let mut match_finish = 0;

    loop {
        if column < 256 {
            break ();
        }
        column = column / 256;
        let current = column % 256;

        if current == prev && prev == prev2 {
            if match_start == 0xff {
                match_start = i - 2;
            }
        } else {
            if match_start != 0xff {
                match_finish = i - 1; // Set previous index as end

                break ();
            }
        }

        prev2 = prev;
        prev = current;
        i = i + 1;
    };
    if match_start == 0xff {
        match_start = 0;
    }

    (match_start, match_finish)
}

#[cfg(test)]
mod test {
    use super::{
        probabilistic_spawn_items_array, generate_columns, column_matches, row_from_columns
    };
    use array::ArrayTrait;
    use starknet::{contract_address_const};
    use debug::PrintTrait;

    #[test]
    #[available_gas(2000000)]
    fn test_probabilistic_spawn_items_array() {
        // relative spawn probabilities: 1 => 1, 2 => 3,4 => 2,
        let spawn_items = probabilistic_spawn_items_array(@array![(1, 1), (2, 3), (4, 2)]);

        assert(spawn_items.len() == 6, 'incorrect spawn items length');
        assert(*spawn_items[0] == 1, 'incorrect spawn items at 0');
        assert(*spawn_items[1] == 2, 'incorrect spawn items at 1');
        assert(*spawn_items[2] == 2, 'incorrect spawn items at 2');
        assert(*spawn_items[3] == 2, 'incorrect spawn items at 3');
        assert(*spawn_items[4] == 4, 'incorrect spawn items at 4');
        assert(*spawn_items[5] == 4, 'incorrect spawn items at 5');
    }

    #[test]
    #[available_gas(2000000)]
    fn test_generate_columns() {
        let spawn_items = probabilistic_spawn_items_array(@array![(1, 1), (2, 3), (4, 2)]);

        let packed_u8_items = generate_columns(
            5, @spawn_items, contract_address_const::<0>(), 0x234
        );
        // Should be of size 5 * 8 bytes, i.e. > 2 ^ 8 ^ 4
        assert(packed_u8_items > 0x0100000000, 'should pack 5 u8s');
    }

    #[test]
    #[available_gas(2000000)]
    fn test_column_matches() {
        // 3 match 4 - 6
        let (s, f) = column_matches(0x403030306020201);
        assert(s == 4, 'incorrect start');
        assert(f == 6, 'incorrect finish');

        // 4 match 0 - 3
        let (s, f) = column_matches(0x403030602020202);
        assert(s == 0, 'incorrect start');
        assert(f == 3, 'incorrect finish');

        // No match
        let (s, f) = column_matches(0x506020030303201);
        assert(s == 0, 'incorrect start');
        assert(f == 0, 'incorrect finish');
    }

    #[test]
    #[available_gas(20000000)]
    fn test_row_from_columns() {
        let cols = array![0x2030401, 0x2020303, 0x3040401, 0x5030504];
        let row = row_from_columns(@cols, 3);
        assert(row == 0x2020305, 'incorrect row');
    }
}
