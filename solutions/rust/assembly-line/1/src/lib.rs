// This stub file contains items which aren't used yet; feel free to remove this module attribute
// to enable stricter warnings.
#![allow(unused)]

pub fn production_rate_per_hour(speed: u8) -> f64 {
    if speed > 8 {
        (speed as f64) * 221f64 * 0.77f64
    } else if speed > 4 && speed < 9 {
        (speed as f64) * 221f64 * 0.90f64
    } else {
        (speed as f64) * 221f64
    }
    
}

pub fn working_items_per_minute(speed: u8) -> u32 {
    production_rate_per_hour(speed) as u32 / 60
}
