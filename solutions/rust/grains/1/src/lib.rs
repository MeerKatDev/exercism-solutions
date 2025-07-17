pub fn square(s: u32) -> u64 {
    assert!(s > 0 && s < 65, "Square must be between 1 and 64");
    2u64.pow(s-1)
}

pub fn total() -> u64 {
    (0..64).fold(0, |acc, x| acc + 2_u64.pow(x))
}
