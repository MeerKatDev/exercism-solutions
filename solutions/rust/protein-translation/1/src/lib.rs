use std::collections::HashMap;

pub struct CodonsInfo<'a> {
    // We fake using 'a here, so the compiler does not complain that
    // "parameter `'a` is never used". Delete when no longer needed.
    phantom: std::marker::PhantomData<&'a ()>,
    pairs: HashMap<&'a str, &'a str>
}

impl<'a> CodonsInfo<'a> {
    pub fn name_for(&self, codon: &str) -> Option<&'a str> {
        self.pairs.get(codon).copied()
    }

    pub fn of_rna(&self, rna: &str) -> Option<Vec<&'a str>> {
        let arr: Vec<Option<&str>> = rna
            .chars()
            .collect::<Vec<char>>()
            .chunks(3)
            .map(|x| {
                println!("{:?}", x);
                x.iter().collect::<String>()
            })
            .take_while(|s| {
                !["UAA", "UAG", "UGA"].contains(&&s[..])
            })
            .map(|s| {
                self.name_for(&s)
            }).collect();

        if arr.iter().any(|x| x.is_none()) {
            None
        } else {
            let v: Vec<&str> = arr.iter().map(|x| x.unwrap()).collect();
            Some(v)
        }
    }
}

pub fn parse<'a>(pairs: Vec<(&'a str, &'a str)>) -> CodonsInfo<'a> {
    let m: HashMap<_, _> = pairs.into_iter().collect();
    CodonsInfo {phantom: Default::default(), pairs: m}
}
