pub fn brackets_are_balanced(string: &str) -> bool {
    let mut stack: Vec<char> = Vec::new();
    
    for c in string.chars() {
        match c {
            '(' | '[' | '{' => stack.push(c),
            ')' if stack.pop().unwrap_or('0') != '(' => return false,
            ']' if stack.pop().unwrap_or('0') != '[' => return false,
            '}' if stack.pop().unwrap_or('0') != '{' => return false,
            _ => (),
        }
    }
    
    stack.is_empty()
}
