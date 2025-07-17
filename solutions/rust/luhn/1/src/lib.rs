/// Check a Luhn checksum.
// with regex it'd be much easier, trying without
pub fn is_valid(code: &str) -> bool {
    let trimmed = str::replace(code, " ", "");
    
    if trimmed.len() < 2 {
        return false
    }

    let mut acc = 0;

    for (i, c) in trimmed.chars().rev().enumerate() {
        match c.to_digit(10) {
            None => return false,
            Some(mut num) => {
                if i % 2 == 1 {
                    num *= 2;
                    if num > 9 {
                        num -= 9;
                    }
                }
                acc += num;
            }
        }
    }

    acc % 10 == 0
}
