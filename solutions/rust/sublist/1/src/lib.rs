#[derive(Debug, PartialEq, Eq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

fn contains<T: PartialEq>(fst: &[T], snd: &[T]) -> bool {
    snd.is_empty() || fst.windows(snd.len()).any(|x| x == snd)
}

pub fn sublist<T: PartialEq>(first_list: &[T], second_list: &[T]) -> Comparison {
    if first_list == second_list {
        Comparison::Equal
    } else if contains(second_list, first_list) {
        Comparison::Sublist
    } else if contains(first_list, second_list) {
        Comparison::Superlist
    } else {
        Comparison::Unequal
    }
}
