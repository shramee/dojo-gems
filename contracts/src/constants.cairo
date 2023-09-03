use super::components::{ItWt, IQty};
use array::ArrayTrait;

#[derive(Copy, Drop)]
struct LevelConfig {
    grid_size: u8,
    spawn_types: (ItWt, ItWt, ItWt, ItWt, ItWt),
// clear_requirement: (IQty, IQty, IQty, IQty, IQty),
}

fn get_level_config(level: usize) -> LevelConfig {
    let mut levels = ArrayTrait::new();

    levels
        .append(
            LevelConfig {
                grid_size: 0, // clear_requirement: ((0, 0), (0, 0), (0, 0), (0, 0), (0, 0)),
                spawn_types: ((0, 0), (0, 0), (0, 0), (0, 0), (0, 0)),
            }
        );
    // Level 1
    levels
        .append(
            LevelConfig {
                grid_size: 6, // clear_requirement: ((1, 10), (0, 0), (0, 0), (0, 0), (0, 0)),
                spawn_types: ((1, 1), (2, 1), (0, 0), (0, 0), (0, 0)),
            }
        );
    // Level 2
    levels
        .append(
            LevelConfig {
                grid_size: 6, // clear_requirement: ((2, 10), (0, 0), (0, 0), (0, 0), (0, 0)),
                spawn_types: ((1, 2), (2, 1), (0, 0), (0, 0), (0, 0)),
            }
        );
    // Level 3
    levels
        .append(
            LevelConfig {
                grid_size: 6, // clear_requirement: ((1, 8), (2, 8), (0, 0), (0, 0), (0, 0)),
                spawn_types: ((1, 1), (2, 1), (3, 1), (0, 0), (0, 0)),
            }
        );
    // Level 4
    levels
        .append(
            LevelConfig {
                grid_size: 6, // clear_requirement: ((3, 10), (0, 0), (0, 0), (0, 0), (0, 0)),
                spawn_types: ((3, 1), (0, 0), (0, 0), (0, 0), (0, 0)),
            }
        );
    // Level 5
    levels
        .append(
            LevelConfig {
                grid_size: 6, // clear_requirement: ((1, 8), (2, 8), (3, 8), (0, 0), (0, 0)),
                spawn_types: ((1, 1), (2, 1), (3, 1), (0, 0), (0, 0)),
            }
        );
    // Level 6
    levels
        .append(
            LevelConfig {
                grid_size: 7, // clear_requirement: ((1, 12), (2, 12), (0, 0), (0, 0), (0, 0)),
                spawn_types: ((1, 1), (2, 1), (0, 0), (0, 0), (0, 0)),
            }
        );
    // Level 7
    levels
        .append(
            LevelConfig {
                grid_size: 7, // clear_requirement: ((1, 10), (2, 10), (4, 10), (0, 0), (0, 0)),
                spawn_types: ((1, 1), (2, 1), (4, 1), (0, 0), (0, 0)),
            }
        );
    // Level 8
    levels
        .append(
            LevelConfig {
                grid_size: 7, // clear_requirement: ((3, 12), (5, 12), (0, 0), (0, 0), (0, 0)),
                spawn_types: ((3, 1), (5, 1), (0, 0), (0, 0), (0, 0)),
            }
        );
    // Level 9
    levels
        .append(
            LevelConfig {
                grid_size: 7, // clear_requirement: ((1, 15), (2, 15), (4, 15), (5, 15), (0, 0)),
                spawn_types: ((1, 1), (2, 1), (4, 1), (5, 1), (0, 0)),
            }
        );
    // Level 10
    levels
        .append(
            LevelConfig {
                grid_size: 7, // clear_requirement: ((1, 20), (2, 20), (3, 20), (4, 20), (5, 20)),
                spawn_types: ((1, 1), (2, 1), (3, 1), (4, 1), (5, 1)),
            }
        );

    *levels[level]
}
