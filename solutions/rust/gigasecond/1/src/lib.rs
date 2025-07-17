use time::PrimitiveDateTime as DateTime;
use time::Duration;

const GIGASECOND: i64 = 1_000_000_000;

pub fn after(start: DateTime) -> DateTime {
    start + Duration::seconds(GIGASECOND)
}
