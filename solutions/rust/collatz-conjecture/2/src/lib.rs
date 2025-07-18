pub fn collatz(mut n: u64) -> Option<u64> {
    if n < 1 {
        return None;
    }

    let mut steps = 0;
    
    while n > 1 {
        n = if n % 2 == 0 {
            n / 2
        } else {
            n.checked_mul(3)?.checked_add(1)?
        };
        steps += 1;
    }

    Some(steps)
}