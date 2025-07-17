pub fn nth(n: u32) -> u32 {
    let mut res: u32 = 2;
    let mut cc: u32 = 0;
    let mut upp;

    // kinda brute force but it works nicely
    // and a nice occasion to use labels
    'outer: for i in 2..=104743 {
        upp = ((i+1) as f32).sqrt().ceil() as u32;
        
        'inner: for j in 2..=upp {
            
            if i % j == 0 {
                break 'inner;
            }

            if upp == j {
                cc += 1;

                if cc == n {
                    res = i;
                    break 'outer;
                }
            }
        }
    }

    res
}
