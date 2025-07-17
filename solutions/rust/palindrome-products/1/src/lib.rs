/// `Palindrome` is a newtype which only exists when the contained value is a palindrome number in base ten.
///
/// A struct with a single field which is used to constrain behavior like this is called a "newtype", and its use is
/// often referred to as the "newtype pattern". This is a fairly common pattern in Rust.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct Palindrome(u64);

impl Palindrome {
    /// Create a `Palindrome` only if `value` is in fact a palindrome when represented in base ten. Otherwise, `None`.
    pub fn new(value: u64) -> Option<Palindrome> {
        if is_palindrome(value) {
            Some(Self(value))
        } else{
            None
        }
    }

    /// Get the value of this palindrome.
    pub fn into_inner(self) -> u64 {
        self.0
    }
}

pub fn palindrome_products(min: u64, max: u64) -> Option<(Palindrome, Palindrome)> {
    let mut range = (min..=max).flat_map(|f1| (f1..=max).map(move |f2| f1 * f2));
    let mut rev = range.clone().rev().collect::<Vec<u64>>();
    rev.sort_by(|a, b| b.partial_cmp(a).unwrap());
    
    if let (Some(minn), Some(maxx)) = (
        range.find(|&x| is_palindrome(x)), 
        rev.into_iter().find(|&x| is_palindrome(x))
    ) {
        Some((Palindrome(minn), Palindrome(maxx)))
    } else {
        None
    }
}

pub fn is_palindrome(num: u64) -> bool {
    let orig = num.to_string().chars().collect::<Vec<char>>();
    let mut rev = orig.to_vec();
    rev.reverse();
    if rev.eq(&orig) {
        println!("{:?} {:?}", orig, rev);
    }
    rev.eq(&orig)
}