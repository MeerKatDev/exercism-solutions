use std::collections::HashMap;

const LETTERS: [char;4] = ['A','C','G','T'];

pub fn count(nucleotide: char, dna: &str) -> Result<usize, char> {
    if valid_dna(dna) && valid_letter(&nucleotide) {
        let num = dna
            .chars()
            .collect::<Vec<_>>()
            .into_iter()
            .filter(|&x| x == nucleotide)
            .count();
        
        Ok(num)
    } else {
        Err('X')
    }
}

pub fn nucleotide_counts(dna: &str) -> Result<HashMap<char, usize>, char> {
    if valid_dna(dna) {
        let hm = LETTERS
            .into_iter()
            .map(|x| (x, count(x, dna).unwrap()))
            .collect::<HashMap<_,_>>();
        
        Ok(hm)
    } else {
        Err('X')
    }
}

pub fn valid_dna(dna: &str) -> bool {
    dna.chars().collect::<Vec<_>>().iter().all(valid_letter)
}

pub fn valid_letter(nucleotide: &char) -> bool {
    LETTERS.contains(&nucleotide)
}
