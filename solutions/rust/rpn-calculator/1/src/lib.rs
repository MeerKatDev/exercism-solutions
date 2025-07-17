#[derive(Debug)]
pub enum CalculatorInput {
    Add,
    Subtract,
    Multiply,
    Divide,
    Value(i32),
}

pub fn evaluate(inputs: &[CalculatorInput]) -> Option<i32> {
    let mut stack: Vec<i32> = Vec::new();
    
    for val in inputs {
        if let CalculatorInput::Value(n) = val {
            stack.push(*n)
        } else if stack.len() >= 2 {
            let b = stack.pop().unwrap();
            let a = stack.pop().unwrap();
            
            match val {
                CalculatorInput::Add => stack.push(a + b),
                CalculatorInput::Subtract => stack.push(a - b),
                CalculatorInput::Multiply => stack.push(a * b),
                CalculatorInput::Divide => stack.push(a / b),
                _ => (),
            }
        } else {
            return None
        }
    }
    
    if stack.len() == 1 {
        Some(stack.pop().unwrap())
    } else {
        None
    }
}