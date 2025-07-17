// This annotation prevents Clippy from warning us that `School` has a
// `fn new()` with no arguments, but doesn't implement the `Default` trait.
//
// Normally, it's good practice to just do what Clippy tells you, but in this
// case, we want to keep things relatively simple. The `Default` trait is not the point
// of this exercise.
use std::collections::HashMap;

#[allow(clippy::new_without_default)]
pub struct School {
    roster: HashMap<String, u32>
}

impl School {
    pub fn new() -> School {
        Self { roster: HashMap::new() }
    }

    pub fn add(&mut self, grade: u32, student: &str) {
        self.roster.insert(String::from(student), grade);
    }

    pub fn grades(&self) -> Vec<u32> {
        let mut ordd = self.roster.values().into_iter()
        .map(|&i| i)
        .collect::<Vec<u32>>();
        ordd.sort();
        ordd.dedup();
        ordd
    }

    // If `grade` returned a reference, `School` would be forced to keep a `Vec<String>`
    // internally to lend out. By returning an owned vector of owned `String`s instead,
    // the internal structure can be completely arbitrary. The tradeoff is that some data
    // must be copied each time `grade` is called.
    pub fn grade(&self, grade: u32) -> Vec<String> {
        let mut ordd = self.roster.iter()
        .filter(|(_, &g)| g == grade)
        .collect::<HashMap<&String, &u32>>()
        .keys()
        .into_iter()
        .map(|&i| String::from(i))
        .collect::<Vec<String>>();
        ordd.sort();
        ordd
    }
}
