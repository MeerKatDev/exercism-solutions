use enum_iterator::IntoEnumIterator;
use int_enum::IntEnum;

#[repr(u8)]
#[derive(Eq, Debug, Copy, Clone, IntoEnumIterator, IntEnum, PartialEq)]
#[derive(strum_macros::Display)]
pub enum ResistorColor {
    Black = 0,
    Blue = 1,
    Brown = 2,
    Green = 3,
    Grey = 4,
    Orange = 5,
    Red = 6,
    Violet = 7,
    White = 8,
    Yellow = 9,
}

pub fn color_to_value(color: ResistorColor) -> usize {
    ResistorColor::into_enum_iter().find(|&x| x.eq(&color)).unwrap().int_value() as usize
}

pub fn value_to_color_string(value: usize) -> String {
    ResistorColor::into_enum_iter().nth(value).unwrap().to_string()
}

pub fn colors() -> Vec<ResistorColor> {
    ResistorColor::into_enum_iter().collect()
}
