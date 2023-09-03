use array::ArrayTrait;
use dojo_gems::types::LevelData;

fn get_all_levels_config() -> Array<LevelData> {
    let mut levels = ArrayTrait::new();
    levels
        .append(
            LevelData {
                number: 0,
                grid_size: 0,
                clear_requirement: array![(0, 0)],
                spawn_types: array![(0, 0)],
            }
        );

    // Level 1
    levels
        .append(
            LevelData {
                number: 1,
                grid_size: 6,
                clear_requirement: array![(1, 10)],
                spawn_types: array![(1, 1), (2, 1)],
            }
        );
    // Level 2
    levels
        .append(
            LevelData {
                number: 2,
                grid_size: 6,
                clear_requirement: array![(2, 10)],
                spawn_types: array![(1, 2), (2, 1)],
            }
        );
    // Level 3
    levels
        .append(
            LevelData {
                number: 3,
                grid_size: 6,
                clear_requirement: array![(1, 8), (2, 8)],
                spawn_types: array![(1, 1), (2, 1), (3, 1)],
            }
        );
    // Level 4
    levels
        .append(
            LevelData {
                number: 4,
                grid_size: 6,
                clear_requirement: array![(3, 10)],
                spawn_types: array![(3, 1)],
            }
        );
    // Level 5
    levels
        .append(
            LevelData {
                number: 5,
                grid_size: 6,
                clear_requirement: array![(1, 8), (2, 8), (3, 8)],
                spawn_types: array![(1, 1), (2, 1), (3, 1)],
            }
        );
    // Level 6
    levels
        .append(
            LevelData {
                number: 6,
                grid_size: 7,
                clear_requirement: array![(1, 12), (2, 12)],
                spawn_types: array![(1, 1), (2, 1)],
            }
        );
    // Level 7
    levels
        .append(
            LevelData {
                number: 7,
                grid_size: 7,
                clear_requirement: array![(1, 10), (2, 10), (4, 10)],
                spawn_types: array![(1, 1), (2, 1), (4, 1)],
            }
        );
    // Level 8
    levels
        .append(
            LevelData {
                number: 8,
                grid_size: 7,
                clear_requirement: array![(3, 12), (5, 12)],
                spawn_types: array![(3, 1), (5, 1)],
            }
        );
    // Level 9
    levels
        .append(
            LevelData {
                number: 9,
                grid_size: 7,
                clear_requirement: array![(1, 15), (2, 15), (4, 15), (5, 15)],
                spawn_types: array![(1, 1), (2, 1), (4, 1), (5, 1)],
            }
        );
    // Level 10
    levels
        .append(
            LevelData {
                number: 1,
                grid_size: 7,
                clear_requirement: array![(1, 20), (2, 20), (3, 20), (4, 20), (5, 20)],
                spawn_types: array![(1, 1), (2, 1), (3, 1), (4, 1), (5, 1)],
            }
        );
    levels
}
