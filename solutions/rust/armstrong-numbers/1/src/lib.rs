pub fn is_armstrong_number(num: u64) -> bool {
    let digits: Vec<u64> = num
        .to_string()
        .chars()
        .map(|d| d.to_digit(10).unwrap() as u64)
        .collect();
    
    let digits_num = digits.len() as u32;

    digits.iter().fold(0, |acc, d| acc + d.pow(digits_num)) == num
}
