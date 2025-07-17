pub fn reply(message: &str) -> &str {
    if message.trim() == "" {
        "Fine. Be that way!"
    } else if is_question(message) && is_uppercase(message) && has_letters(message) {
        "Calm down, I know what I'm doing!"
    } else if is_question(message) {
        "Sure."
    } else if is_uppercase(message) && has_letters(message) {
        "Whoa, chill out!"
    } else {
        "Whatever."
    }
}

fn has_letters(message: &str) -> bool {
    message.chars().any(|x| x.is_alphabetic())
}

fn is_uppercase(message: &str) -> bool {
    message == message.to_ascii_uppercase()
}

fn is_question(message: &str) -> bool {
    message.trim().chars().last().unwrap() == '?'
}