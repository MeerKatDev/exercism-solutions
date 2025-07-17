pub fn annotate(minefield: &[&str]) -> Vec<String> {
    if minefield.is_empty() || minefield[0].is_empty() { 
        return minefield.iter().map(|&s| s.to_owned()).collect()
    }
    
    let h = minefield.len();
    let w = minefield[0].len();
    println!("h={}, w={}", h, w);
    
    let mut res: Vec<String> = vec![String::new();h];
    let mut acc: u32 = 0;
    let mut row: Vec<char>;
    
    for r in 0..h {
        row = minefield[r].chars().collect();
        for c in 0..w {
            if row[c] == ' ' {
                acc = get_mine(&minefield, r + 1, c) + get_mine(&minefield, r, c + 1);
                acc += get_mine(&minefield, r + 1, c + 1);
                if r > 0 {
                    acc += get_mine(&minefield, r - 1, c + 1);
                    acc += get_mine(&minefield, r - 1, c);
                }
                if c > 0 {
                    acc += get_mine(&minefield, r + 1, c - 1);
                    acc += get_mine(&minefield, r, c - 1);
                }
                if c > 0 && r > 0 {
                    acc += get_mine(&minefield, r - 1, c - 1);
                }
                
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
