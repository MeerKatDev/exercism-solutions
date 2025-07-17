pub fn verse(n: u32) -> String {
    if n == 0 {
        String::from("No more bottles of beer on the wall, no more bottles of beer.\n\
        Go to the store and buy some more, 99 bottles of beer on the wall.\n")
    } else if n == 1 {
        String::from("1 bottle of beer on the wall, 1 bottle of beer.\n\
        Take it down and pass it around, no more bottles of beer on the wall.\n")
    } else if n == 2 {
        String::from("2 bottles of beer on the wall, 2 bottles of beer.\n\
        Take one down and pass it around, 1 bottle of beer on the wall.\n")
    } else {
        let m = n - 1;
        String::from(format!("{n} bottles of beer on the wall, {n} bottles of beer.\n\
        Take one down and pass it around, {m} bottles of beer on the wall.\n"))
    }
}

pub fn sing(start: u32, end: u32) -> String {
    (end..=start).map(|i| verse(i)).rev().collect::<Vec<String>>().join("\n")
}
