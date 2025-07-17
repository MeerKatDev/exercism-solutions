pub fn annotate(minefield: &[&str]) -> Vec<String> {
    if minefield.is_empty() || minefield[0].is_empty() { 
        return minefield.iter().map(|&s| s.to_owned()).collect()
    }
    
    let h = minefield.len();
    let w = minefield[0].len();
    
    let mut res: Vec<String> = vec![String::new();h];
    let mut acc: u32 = 0;
    let mut row: Vec<char>;
    
    for r in 0..h {
        row = minefield[r].chars().collect();
        for c in 0..w {
            if row[c] == ' ' {
                acc = sum_around(&minefield, r, c);
                
                if acc > 0 {
                    res[r].push(char::from_digit(acc, 10).unwrap());
                } else {
                    res[r].push(' ');
                }
            } else {
                res[r].push('*');
            }
        }
    }

    res

}

fn sum_around(minefield: &[&str], r: usize, c: usize) -> u32 {
    let mut acc = 0;
    for rr in r.saturating_sub(1)..=r+1 {
        for cc in c.saturating_sub(1)..=c+1 {
            if !(r == rr && c == cc) {
                acc += get_mine(&minefield, rr, cc);
            }
        }    
    }
    acc
}

fn get_mine(minefield: &[&str], r: usize, c: usize) -> u32 {
    if let Some(&row) = minefield.get(r) {
        match row.chars().nth(c) {
            Some('*') => 1,
            _ => 0,
        }
    } else { 
        0 
    }  
}
