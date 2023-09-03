type Item = u8;

type ItWt = (Item, u8);

type IQty = (Item, u8);

#[derive(Drop, Serde)]
struct LevelData {
    number: u8,
    grid_size: u8,
    spawn_types: Array<ItWt>,
    clear_requirement: Array<IQty>,
}

#[derive(Copy, Drop, Serde)]
enum Direction {
    Up: (),
    Down: (),
    Left: (),
    Right: (),
}
