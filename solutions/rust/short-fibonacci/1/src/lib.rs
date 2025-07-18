/// Create an empty vector
pub fn create_empty() -> Vec<u8> {
    Vec::new()
}

/// Create a buffer of `count` zeroes.
///
/// Applications often use buffers when serializing data to send over the network.
pub fn create_buffer(count: usize) -> Vec<u8> {
    vec![0;count]
}

/// Create a vector containing the first five elements of the Fibonacci sequence.
///
/// Fibonacci's sequence is the list of numbers where the next number is a sum of the previous two.
/// Its first five elements are `1, 1, 2, 3, 5`.
pub fn fibonacci() -> Vec<u8> {
    let mut v: Vec<u8> = create_empty();
    let elements = 5;
    
    for i in 0..elements {
        if i > 1 {
            v.push(v.get(i-2).unwrap() + v.get(i-1).unwrap())
        } else {
            v.push(1)
        }
    }
    
    v
}
