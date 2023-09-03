#[system]
mod swap {
    use array::ArrayTrait;
    use box::BoxTrait;
    use traits::{Into, TryInto};
    use option::OptionTrait;
    use dojo_gems::types::{LevelData, Direction};
    use dojo_gems::utils::{get_player_grid, swap_grid};
    use dojo::world::Context;

    fn execute(ctx: Context, row_index: u128, col_index: u128, direction: Direction) {
        let grid = get_player_grid(ctx.world, ctx.origin);
        swap_grid(ctx, row_index, col_index, direction);
        return ();
    }
}

