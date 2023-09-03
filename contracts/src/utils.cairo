use dojo_gems::types::{LevelData};
use array::{ArrayTrait, Array};
use core::traits::{Into, TryInto};
use option::OptionTrait;
use serde::Serde;

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
// let mut clear_requirement = Array::new();
// let mut spawn_types = Array::new();
// let mut i = 0;
// loop {}

// LevelData { grid_size: *level_snap.grid_size, clear_requirement, spawn_types }
}
