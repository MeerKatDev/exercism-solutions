#[derive(Debug, PartialEq)]
pub struct Clock {
    hours: u32,
    minutes: u32
}

impl Clock {
    pub fn new(hours: i32, minutes: i32) -> Self {
      let time = (hours * 60 + minutes).rem_euclid(24 * 60);
      Self { hours: (time / 60) as u32, minutes: (time % 60) as u32 }
    }

    pub fn add_minutes(&self, minutes: i32) -> Self {
        Self::new(self.hours as i32, minutes + (self.minutes as i32))
    }

    pub fn to_string(&self) -> String {
        format!("{:02}:{:02}", self.hours, self.minutes)
    }
}
