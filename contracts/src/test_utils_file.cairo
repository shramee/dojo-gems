#[cfg(test)]
mod test_utils {
    use dojo_gems::components::{Column, Level, Assets};
    use dojo_gems::components::{column, level, assets};
    use dojo_gems::systems::{game::start_game};
    use dojo::world::{IWorldDispatcher, IWorldDispatcherTrait};
    use dojo_gems::systems::readers::{get_player_level};
    use dojo::test_utils::spawn_test_world;
    // helper setup function
    // reuse this function for all tests
    fn setup_world() -> IWorldDispatcher {
        // components
        let mut components = array![
            column::TEST_CLASS_HASH, level::TEST_CLASS_HASH, assets::TEST_CLASS_HASH
        ];

        // systems
        let mut systems = array![start_game::TEST_CLASS_HASH, get_player_level::TEST_CLASS_HASH];

        // deploy executor, world and register components/systems
        spawn_test_world(components, systems)
    }
}
