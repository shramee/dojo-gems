#[system]
mod swap {
    use array::ArrayTrait;
    use box::BoxTrait;
    use traits::{Into, TryInto};
    use option::OptionTrait;
    use dojo_gems::types::{LevelData, Direction};
    use dojo::world::Context;

    fn execute(ctx: Context, row_index: u8, col_index: u8, direction: Direction) {
        match direction {
            Direction::Up => {},
            Direction::Down => {},
            Direction::Left => {},
            Direction::Right => {},
        };
        return ();
    }
}

