// This stub file contains items which aren't used yet; feel free to remove this module attribute
// to enable stricter warnings.
#![allow(unused)]

pub struct Player {
    pub health: u32,
    pub mana: Option<u32>,
    pub level: u32,
}

impl Player {
    pub fn revive(&self) -> Option<Player> {
        match self {
            &Player{health: 0, level: lvl, ..} if lvl >= 10 => 
                Some(Self { health: 100, mana: Some(100), level: lvl }),
            &Player{health: 0, level: lvl, ..} => 
                Some(Self { health: 100, mana: None, level: lvl }),
            _ => None
        }
    }

    pub fn cast_spell(&mut self, mana_cost: u32) -> u32 {
        match self.mana {
            Some(x) if x >= mana_cost => {
                self.mana = Some(x - mana_cost);
                mana_cost * 2
            }
            Some(x) => 0,
            None    => {
                self.health = self.health.saturating_sub(mana_cost);
                0
            }
        }
    }
}
