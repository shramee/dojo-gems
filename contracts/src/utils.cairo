use integer::{u128s_from_felt252, U128sFromFelt252Result};
use dojo_gems::types::{LevelData};
use starknet::ContractAddress;
use array::{ArrayTrait, Array};
use core::traits::{Into, TryInto};
use option::OptionTrait;
use serde::Serde;
use debug::PrintTrait;

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

fn generate_row(
    grid_size: u8, spawn_types: @Array<u8>, player: ContractAddress, salt: felt252
) -> u128 {
    let mut column = 0_u128;
    let mut j = 0;
    let spawn_types_len = spawn_types.len();

    let mut random = match u128s_from_felt252(pedersen(player.into(), salt)) {
        U128sFromFelt252Result::Narrow(x) => x,
        U128sFromFelt252Result::Wide((_, x)) => x,
    };

    // add type_id probability times
    loop {
        if grid_size == j {
            break;
        };

        // pop off random 8 bits
        let rand_u8: u32 = (random % 256).try_into().unwrap();
        random = random / 256;
        let rand_index: u32 = rand_u8 % spawn_types_len;

        // (rand_u8 * 0xf00 + rand_index).print();

        column = column * 256 + (*spawn_types[rand_index]).into();
        j += 1;
    };

    column
}

// Just one level for now
fn get_level_data(number: u8) -> LevelData {
    return LevelData {
        number,
        grid_size: 6,
        clear_requirement: array![(1, 10)],
        spawn_types: array![(1, 1), (2, 1), (3, 1), (4, 1)],
    };
}

#[cfg(test)]
mod test {
    use super::{probabilistic_spawn_items_array, generate_row};
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
    fn test_generate_row() {
        let spawn_items = probabilistic_spawn_items_array(@array![(1, 1), (2, 3), (4, 2)]);

        let packed_u8_items = generate_row(5, @spawn_items, contract_address_const::<0>(), 0x234);
        // Should be of size 5 * 8 bytes, i.e. > 2 ^ 8 ^ 4
        assert(packed_u8_items > 0x0100000000, 'should pack 5 u8s');
    }
}
