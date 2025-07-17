// use std::collections::HashMap;

pub fn can_construct_note(magazine: &[&str], note: &[&str]) -> bool {
    let mut mag_vec = magazine.to_vec();
    
    for n in note {
        match mag_vec.iter().position(|x| x == n) {
            Some(pos) => mag_vec.swap_remove(pos),
            None => return false,
        };
        ()
    }

    true
}
