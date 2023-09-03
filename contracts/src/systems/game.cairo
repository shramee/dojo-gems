use core::array::SpanTrait;
use dojo::world::IWorldDispatcherTrait;
#[system]
mod start_game {
    use array::ArrayTrait;
    use box::BoxTrait;
    use traits::{Into, TryInto};
    use option::OptionTrait;
    use dojo::world::Context;

    use dojo_gems::components::{Level, Column, };
    use dojo_gems::types::{Item, LevelData};
    use dojo_gems::utils::get_level_data;

    fn generate_row(level: @LevelData) -> u128 {
        0xf00dee
    }

    fn execute(ctx: Context) -> Level {
        // Player level number (@TODO multilevel later)
        let level_number = 1;
        let player = ctx.origin;

        // player Level
        let player_level = Level { player, level_number };
        // get level data
        let level = get_level_data(level_number);

        let mut index = 0;

        // generate grid columns
        loop {
            if level.grid_size == index {
                break;
            };
            index += 1;
            set!(ctx.world, Column { player, index, packed_u8_items: generate_row(@level) });
        };

        set!(ctx.world, (player_level));
        return player_level;
    }
}

#[cfg(test)]
mod tests {
    use array::{SpanTrait, ArrayTrait};
    use box::BoxTrait;
    use traits::{Into, TryInto};
    use option::OptionTrait;
    use dojo_gems::test_utils::setup_world;
    use dojo::world::IWorldDispatcherTrait;
    use debug::PrintTrait;

    #[test]
    #[available_gas(30000000)]
    fn test_start_game() {
        let world = setup_world();
        let start_res = world.execute('start_game', array![]);

        start_res.len().print();
    }
}
