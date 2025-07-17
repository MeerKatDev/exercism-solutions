pub fn reply(message: &str) -> &str {
    match message {
        m if m.trim() == "" => "Fine. Be that way!",
        m if is_question(m) && is_uppercase(m) && has_letters(m) => 
            "Calm down, I know what I'm doing!",
        m if is_question(m) => "Sure.",
        m if is_uppercase(m) && has_letters(m) => "Whoa, chill out!",
        _ => "Whatever."
    }
}

fn has_letters(message: &str) -> bool {
    message.chars().any(|x| x.is_alphabetic())
}

fn is_uppercase(message: &str) -> bool {
    message == message.to_ascii_uppercase()
}

fn is_question(message: &str) -> bool {
    message.trim().ends_with("?")
}