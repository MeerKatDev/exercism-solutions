use std::collections::HashMap;
use std::str;

pub struct CodonsInfo<'a> {
    pairs: HashMap<&'a str, &'a str>
}

impl<'a> CodonsInfo<'a> {
    const CODON_SIZE: usize = 3;
    const STOP: &str = "stop codon";
    
    pub fn name_for(&self, codon: &str) -> Option<&str> {
        self.pairs.get(codon).copied()
    }

    pub fn of_rna(&self, rna: &str) -> Option<Vec<&str>> {
        rna
        .as_bytes()
        .chunks(Self::CODON_SIZE)
        .map(str::from_utf8)
        .map_while(|x|
            match self.name_for(x.unwrap()) {
                Some(Self::STOP) => None,
                m => Some(m)
            }
        ).collect()
    }
}

pub fn parse<'a>(pairs: Vec<(&'a str, &'a str)>) -> CodonsInfo<'a> {
    let m: HashMap<_, _> = pairs.into_iter().collect();
    CodonsInfo {pairs: m}
}
