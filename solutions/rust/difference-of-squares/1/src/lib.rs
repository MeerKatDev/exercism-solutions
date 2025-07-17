pub fn square_of_sum(n: u32) -> u32 {
    (1..=n).reduce(|acc,e| acc + e).unwrap().pow(2)
}

pub fn sum_of_squares(n: u32) -> u32 {
    (1..=n).reduce(|acc,e| acc + e.pow(2)).unwrap()
}

pub fn difference(n: u32) -> u32 {
    square_of_sum(n) - sum_of_squares(n) 
}
