use dojo_gems::types::{LevelData};
use array::{ArrayTrait, Array};
use core::traits::{Into, TryInto};
use option::OptionTrait;
use serde::Serde;

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

// Just one level for now
fn get_level_data(number: u8) -> LevelData {
    return LevelData {
        number,
        grid_size: 6,
        clear_requirement: array![(1, 10)],
        spawn_types: array![(1, 1), (2, 1)],
    };
}

#[cfg(test)]
mod test {
    use super::{probabilistic_spawn_items_array};
    use array::ArrayTrait;

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
}
