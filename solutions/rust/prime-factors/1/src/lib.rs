pub fn factors(n: u64) -> Vec<u64> {
    let mut num = n;
    let mut factors: Vec<u64> = Vec::new();
    let mut x = 2;
    
    loop {
        if num == 1 {
            break;
        }
        
        if num % x == 0 {
            num /= x;
            factors.push(x);
        } else {
            x += 1;
        }
    }

    factors
}
