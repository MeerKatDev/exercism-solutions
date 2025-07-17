use std::collections::HashSet;

pub fn anagrams_for<'a>(word: &str, possible_anagrams: &[&'a str]) -> HashSet<&'a str> {
    let cs = sorted_vec(word.to_lowercase());
    let mut hs = HashSet::new();
    
    for pa in possible_anagrams.iter() {
        if pa.to_lowercase() != word.to_lowercase() && cs == sorted_vec(pa.to_lowercase())  {
            hs.insert(*pa);
        }
    }

    hs
}

fn sorted_vec(word :String) -> Vec<char> {
    let mut cs: Vec<char> = word.chars().collect::<Vec<char>>();
    cs.sort_unstable();
    
    cs
}
