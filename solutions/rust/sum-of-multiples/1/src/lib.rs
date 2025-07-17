pub fn sum_of_multiples(limit: u32, factors: &[u32]) -> u32 {
    (1..limit).fold(0, |acc, x| {
        acc + (if is_multiple(x, factors) { x } else { 0 })
    })
}

fn is_multiple(x: u32, factors: &[u32]) -> bool {
    factors.iter().filter(|&&fac| fac != 0).any(|fac| x % fac == 0)
}