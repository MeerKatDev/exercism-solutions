pub fn series(digits: &str, len: usize) -> Vec<String> {
    let chars: Vec<char> = digits.chars().collect();
    
    if len == 0 || len > chars.len() {
        return vec![];
    }
    
    chars
    .windows(len)
    .map(|window| window.iter().collect::<String>())
    .collect()
}
