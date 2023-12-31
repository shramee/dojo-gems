#[system]
mod get_player_level {
    use starknet::ContractAddress;
    use array::ArrayTrait;
    use box::BoxTrait;
    use traits::{Into, TryInto};
    use option::OptionTrait;
    use dojo::world::Context;

    use dojo_gems::components::{Level, Column,};
    use dojo_gems::types::{Item, LevelData};
    use dojo_gems::utils::get_player_level;

    fn execute(ctx: Context, player: ContractAddress) -> LevelData {
        get_player_level(ctx.world, player)
    }
}
#[system]
mod get_player_grid {
    use starknet::ContractAddress;
    use array::ArrayTrait;
    use box::BoxTrait;
    use traits::{Into, TryInto};
    use option::OptionTrait;
    use dojo::world::Context;

    use dojo_gems::components::{Level, Column,};
    use dojo_gems::types::{Item, LevelData};
    use dojo_gems::utils::get_player_grid;

    fn execute(ctx: Context, player: ContractAddress) -> Array<u128> {
        get_player_grid(ctx.world, player)
    }
}

#[cfg(test)]
mod tests {
    use serde::Serde;
    use array::{SpanTrait, ArrayTrait};
    use box::BoxTrait;
    use traits::{Into, TryInto};
    use option::OptionTrait;
    use dojo_gems::test_utils::setup_world;
    use dojo_gems::types::LevelData;
    use dojo::world::IWorldDispatcherTrait;
    use debug::{print, PrintTrait};

    #[test]
    #[available_gas(30000000)]
    fn test_get_player_level_data() {
        let world = setup_world();
        world.execute('start_game', array![]);
        let mut level_ser = world.execute('get_player_level', array![0x0]);
        let level = Serde::<LevelData>::deserialize(ref level_ser).unwrap();

        assert(level.number == 1, 'level number be 1');
        assert(level.spawn_types.len() > 0, 'level spawn types');
    }

    #[test]
    #[available_gas(30000000)]
    fn test_get_player_grid() {
        let world = setup_world();
        world.execute('start_game', array![]);
        let mut grid = world.execute('get_player_grid', array![0x0]);

        assert((*grid.pop_back().unwrap()).try_into().unwrap() > 0_u128, 'column items empty');
        assert((*grid.pop_back().unwrap()).try_into().unwrap() > 0_u128, 'column items empty');
        assert((*grid.pop_back().unwrap()).try_into().unwrap() > 0_u128, 'column items empty');
        assert((*grid.pop_back().unwrap()).try_into().unwrap() > 0_u128, 'column items empty');
        assert((*grid.pop_back().unwrap()).try_into().unwrap() > 0_u128, 'column items empty');
    }
}
