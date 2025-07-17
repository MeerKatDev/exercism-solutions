pub fn reverse(input: &str) -> String {
    input
    .chars()
    .rfold(Vec::new(), |mut acc, x| { acc.push(x); acc })
    .into_iter()
    .collect()
}
