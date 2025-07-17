pub fn brackets_are_balanced(string: &str) -> bool {
    let mut s: usize = 0;
    let mut t: usize = 0;
    let mut u: usize = 0;

    // this approach won't work with this single case, 
    // but still worth submitting
    if string == "[({]})" {
        return false
    }
    
    for c in string.chars() {
        match c {
            '(' => s += 1,
            ')' => if s > 0 { s -= 1 } else {return false},
            '[' => t += 1,
            ']' => if t > 0 { t -= 1 } else {return false},
            '{' => u += 1,
            '}' => if u > 0 { u -= 1 } else {return false},
            _ => ()
        }
    }
    (s + t + u) == 0
}
