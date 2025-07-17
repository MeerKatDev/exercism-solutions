pub fn build_proverb(list: &[&str]) -> String {
    if list.len() > 0 {
        let mut acc: Vec<String> = vec![format!("And all for the want of a {}.", list[0]).to_owned()];
        let mut it = list.iter().rev();
        let mut prev = it.next().unwrap();
        
        for word in it {
            acc.insert(0,format!("For want of a {word} the {prev} was lost."));
            prev = word;
        }
        acc.join("\n")
    } else {
        String::new()   
    }
}
