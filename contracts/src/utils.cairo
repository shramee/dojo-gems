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
    // let level: felt252 = number.into();
    // let level: u32 = level.try_into().unwrap();
    // let mut levels = ArrayTrait::new();

    return LevelData {
        number,
        grid_size: 6,
        clear_requirement: array![(1, 10)],
        spawn_types: array![(1, 1), (2, 1)],
    };
// levels
//     .append(
//         LevelData {
//             grid_size: 0, clear_requirement: array![(0, 0)], spawn_types: array![(0, 0)], 
//         }
//     );

// // Level 1
// levels
//     .append(
//         LevelData {
//             grid_size: 6,
//             clear_requirement: array![(1, 10)],
//             spawn_types: array![(1, 1), (2, 1)],
//         }
//     );
// // Level 2
// levels
//     .append(
//         LevelData {
//             grid_size: 6,
//             clear_requirement: array![(2, 10)],
//             spawn_types: array![(1, 2), (2, 1)],
//         }
//     );
// // Level 3
// levels
//     .append(
//         LevelData {
//             grid_size: 6,
//             clear_requirement: array![(1, 8), (2, 8)],
//             spawn_types: array![(1, 1), (2, 1), (3, 1)],
//         }
//     );
// // Level 4
// levels
//     .append(
//         LevelData {
//             grid_size: 6, clear_requirement: array![(3, 10)], spawn_types: array![(3, 1)], 
//         }
//     );
// // Level 5
// levels
//     .append(
//         LevelData {
//             grid_size: 6,
//             clear_requirement: array![(1, 8), (2, 8), (3, 8)],
//             spawn_types: array![(1, 1), (2, 1), (3, 1)],
//         }
//     );
// // Level 6
// levels
//     .append(
//         LevelData {
//             grid_size: 7,
//             clear_requirement: array![(1, 12), (2, 12)],
//             spawn_types: array![(1, 1), (2, 1)],
//         }
//     );
// // Level 7
// levels
//     .append(
//         LevelData {
//             grid_size: 7,
//             clear_requirement: array![(1, 10), (2, 10), (4, 10)],
//             spawn_types: array![(1, 1), (2, 1), (4, 1)],
//         }
//     );
// // Level 8
// levels
//     .append(
//         LevelData {
//             grid_size: 7,
//             clear_requirement: array![(3, 12), (5, 12)],
//             spawn_types: array![(3, 1), (5, 1)],
//         }
//     );
// // Level 9
// levels
//     .append(
//         LevelData {
//             grid_size: 7,
//             clear_requirement: array![(1, 15), (2, 15), (4, 15), (5, 15)],
//             spawn_types: array![(1, 1), (2, 1), (4, 1), (5, 1)],
//         }
//     );
// // Level 10
// levels
//     .append(
//         LevelData {
//             grid_size: 7,
//             clear_requirement: array![(1, 20), (2, 20), (3, 20), (4, 20), (5, 20)],
//             spawn_types: array![(1, 1), (2, 1), (3, 1), (4, 1), (5, 1)],
//         }
//     );

// let level_snap = levels[level];
// let mut clear_requirement = ArrayTrait::new();
// let mut spawn_types = ArrayTrait::new();
// let mut i = 0;
// loop {}

// LevelData { grid_size: *level_snap.grid_size, clear_requirement, spawn_types }
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
