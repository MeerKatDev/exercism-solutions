pub fn square(s: u32) -> u64 {
    assert!(s > 0 && s < 65, "Square must be between 1 and 64");
    if s == 1 { 1 } else { 2 << (s-2) }
}

pub fn total() -> u64 {
    (1..=64).fold(0, |acc, x| acc + square(x))
}
