use std::collections::HashMap;
use std::str;

pub struct CodonsInfo<'a> {
    pairs: HashMap<&'a str, &'a str>
}

impl<'a> CodonsInfo<'a> {
    pub fn name_for(&self, codon: &str) -> Option<&str> {
        self.pairs.get(codon).copied()
    }

    pub fn of_rna(&self, rna: &str) -> Option<Vec<&str>> {
        rna
        .as_bytes()
        .chunks(3)
        .map_while(|x| match str::from_utf8(x).unwrap() {
            "UAA" | "UAG" | "UGA" => None,
            s => Some(self.name_for(s)),
        }).collect::<Option<Vec<_>>>()
    }
}

pub fn parse<'a>(pairs: Vec<(&'a str, &'a str)>) -> CodonsInfo<'a> {
    let m: HashMap<_, _> = pairs.into_iter().collect();
    CodonsInfo {pairs: m}
}
