use array::ArrayTrait;
use starknet::ContractAddress;
use serde::Serde;
use dojo::SerdeLen;
// Helper types

type Item = u8;

// Grid column
#[derive(Component, Copy, Drop, Serde, SerdeLen)]
struct Column {
    #[key]
    player: ContractAddress,
    #[key]
    index: u32,
    packed_u8_types: u128, // Upto 16 (128/8) cells
}

// Level player is on
#[derive(Component, Copy, Drop, Serde, SerdeLen)]
struct Level {
    #[key]
    player: ContractAddress,
    level_number: u8,
}

// Player's collected assets
#[derive(Component, Copy, Drop, Serde, SerdeLen)]
struct Assets {
    #[key]
    player: ContractAddress,
    #[key]
    typ: Item,
    quantity: u32,
}

impl TupleSize2SerdeLen<
    E0, E1, impl E0SerdeLen: SerdeLen<E0>, impl E1SerdeLen: SerdeLen<E1>
> of SerdeLen<(E0, E1)> {
    fn len() -> usize {
        E0SerdeLen::len() + E1SerdeLen::len()
    }
}

impl TupleSize4SerdeLen<E0, impl E0SerdeLen: SerdeLen<E0>, > of SerdeLen<(E0, E0, E0, E0)> {
    fn len() -> usize {
        E0SerdeLen::len() * 4
    }
}
impl TupleSize5SerdeLen<E0, impl E0SerdeLen: SerdeLen<E0>, > of SerdeLen<(E0, E0, E0, E0, E0)> {
    fn len() -> usize {
        E0SerdeLen::len() * 5
    }
}

#[derive(Copy, Drop, Serde, SerdeLen)]
type ItWt = (Item, u8);

#[derive(Copy, Drop, Serde, SerdeLen)]
type IQty = (Item, u8);

#[derive(Component, Copy, Drop, Serde, SerdeLen)]
struct LevelDefinition {
    #[key]
    number: u8, // Level number
    grid_size: u8, // Size of grid square
    // Spawn up to 5 types of items and spawn probability
    spawnsItems: (ItWt, ItWt, ItWt, ItWt),
    // Upto 4 types of gems and quantities to collect to clear
    clearReqs: (IQty, IQty, IQty, IQty),
}
