pub fn collatz(n: u64) -> Option<u64> {
    if n > 0 {
        Some(rec(n, 0))
    } else {
        None
    }
    
}

fn rec(n: u64, acc: u64) -> u64 {
    if n > 1 {
        if n % 2 == 0 {
            rec(n / 2, acc + 1)
        } else {
            rec(n * 3 + 1, acc + 1)
        }
    } else { acc }
}