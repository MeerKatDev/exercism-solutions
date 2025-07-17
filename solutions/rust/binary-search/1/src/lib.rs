pub fn find(array: &[i32], key: i32) -> Option<usize> {
    match rec(array, key, 0) {
        (&[num], idx) if num == key => Some(idx),
        (_, _) => None
    }
}

fn rec(array: &[i32], key: i32, idx: usize) -> (&[i32], usize) {
    if array.len() <= 1 {
        return (array, idx)
    } 
    
    let midlen = array.len()/2 - 1;

    if key >= array[midlen] {
        rec(&array[midlen..], key, idx + midlen)
    } else if midlen > idx  {
        rec(&array[..midlen], key, idx + midlen)
    } else {
        rec(&array[..midlen], key, idx)
    }
}
