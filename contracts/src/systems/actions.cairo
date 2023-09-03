#[system]
mod swap {
    use array::ArrayTrait;
    use box::BoxTrait;
    use traits::{Into, TryInto};
    use option::OptionTrait;
    use dojo::world::Context;

    // so we don't go negative

    fn execute(ctx: Context) {
        // set!(
        //     ctx.world,
        //     (
        //         Moves {
        //             player: ctx.origin, remaining: 100
        //             }, Position {
        //             player: ctx.origin, x: offset, y: offset
        //         },
        //     )
        // );
        return ();
    }
}

