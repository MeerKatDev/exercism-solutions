pub fn check(candidate: &str) -> bool {
    let filtered_str = candidate.replace("-", "").replace(" ", "").to_lowercase();
    let mut chars: Vec<u8> = filtered_str.as_str().bytes().collect();
    chars.sort_by(|a, b| b.cmp(a));
    chars.dedup();
    
    chars.len() == filtered_str.len()
}
