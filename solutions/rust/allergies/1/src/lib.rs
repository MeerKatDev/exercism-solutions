pub struct Allergies(Vec<Allergen>);

#[derive(Debug, PartialEq, Eq, Clone)]
pub enum Allergen {
    Eggs,
    Peanuts,
    Shellfish,
    Strawberries,
    Tomatoes,
    Chocolate,
    Pollen,
    Cats,
}

impl Allergies {
    pub fn new(score: u32) -> Self {
        let mut s = score;
        let mut tmp;
        let mut allergies: Vec<Allergen> = Vec::with_capacity(8);
        
        for x in (0..12).rev() {
            tmp = 2 << x;
            
            if tmp <= s { 
                s -= tmp;
                
                if x < 7 {
                    allergies.push( map_allergen(x + 1) );
                }
            }
        }

        // cannot reach this with << operator
        if s == 1 {
            allergies.push(Allergen::Eggs)
        }
        
        Self (allergies)
    }

    pub fn is_allergic_to(&self, allergen: &Allergen) -> bool {
        self.0.iter().find(|&x| x == allergen).is_some()
    }

    pub fn allergies(&self) -> Vec<Allergen> {
        self.0.to_vec()
    }
}

fn map_allergen(n: u32) -> Allergen {
    match n {
        0 => Allergen::Eggs,
        1 => Allergen::Peanuts,
        2 => Allergen::Shellfish,
        3 => Allergen::Strawberries,
        4 => Allergen::Tomatoes,
        5 => Allergen::Chocolate,
        6 => Allergen::Pollen,
        7 => Allergen::Cats,
        _ => panic!("WTF")
    }
}
