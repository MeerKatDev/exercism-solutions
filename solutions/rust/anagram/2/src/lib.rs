use std::collections::HashSet;

pub fn anagrams_for<'a>(word: &str, possible_anagrams: &[&'a str]) -> HashSet<&'a str> {
    let word = word.to_lowercase();
    let cs = sorted_vec(&word);

    possible_anagrams
    .iter()
    .filter(|&&pa| pa.to_lowercase() != word && cs == sorted_vec(&pa.to_lowercase()))
    .copied()
    .collect()
}

fn sorted_vec(word :&str) -> Vec<char> {
    let mut cs: Vec<char> = word.chars().collect::<Vec<char>>();
    cs.sort_unstable();
    cs
}
