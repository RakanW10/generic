// 1. Define the `Item` protocol with the following requirements:
// - `name` property of type `String`
// - `description` property of type `String`

protocol Item {
    var name: String { get }
    var description: String { get }
}

// 2. Define the `Chest` struct with the following requirements:
// - `items` property of type `Array<Item>`

struct Chest {
    var items: Array<Item> = []
}

// 3. Define the `Player` protocol which confirm to `AnyObject` protocol and with the following requirements:
// - `name` property of type `String`
// - `health` property of type `Int`
// - `attack<P: Player>(_ player: P)` function
// - `splash<P: Player>(_ player: P)` function
// - `heal()` function

protocol Player: AnyObject {
    var name: String { get }
    var health: Int { get set }
    var chest: Chest { get set }

    func attack<P: Player>(_ player: P)
    func splash<P: Player>(_ player: P)
    func heal()
}

// 4. Define the `Weapon` protocol which confirm to `Item` protocol and with the following requirements:
// - `effectPoints` property of type `Int`
// - `attack<P: Player>(_ player: P)` function

protocol Weapon: Item {
    var effectPoints: Int { get }
    func attack<P: Player>(_ player: P)
}

// 5. Define the `Potion` protocol which confirm to `Item` protocol and with the following requirements:
// - `effectPoints` property of type `Int`
// - `splash<P: Player>(_ player: P)` function

protocol Potion: Item {
    var effectPoints: Int { get }
    func splash<P: Player>(_ player: P)
}

// 6. Define the `Sword` struct which confirm to `Weapon` protocol
// - the `effectPoints` should be 10

struct Sword: Weapon {
    var effectPoints = 10
    var name = "Regular Sword"
    var description = "Has Damaged you"
    
    func attack<P>(_ player: P) where P: Player {
        if player.health > effectPoints {
            player.health -= effectPoints
            print("you have been slashed by \(name)" + description)
        } else {
            print("you have been killed")
        }
    }
}

// 7. Define the `Axe` struct which confirm to `Weapon` protocol
// - the `effectPoints` should be 20

struct Axe: Weapon {
    var effectPoints = 20
    var name = "Large Axe"
    var description = "Has Damaged you"

    func attack<P>(_ player: P) where P: Player {
        if player.health > effectPoints {
            player.health -= effectPoints
            print("you have been hit by \(name)" + description)
        } else {
            print("you have been killed")
        }
    }
}

// 8. Define the `Knife` struct which confirm to `Weapon` protocol
// - the `effectPoints` should be 5

struct Knife: Weapon {
    var effectPoints = 5
    var name = "Small Knife"
    var description = "Has Damaged you"

    func attack<P>(_ player: P) where P: Player {
        if player.health > effectPoints {
            player.health -= effectPoints
            print("you have been stabbed by \(name)" + description)
        } else {
            print("you have been killed")
        }
    }
}

// 9. Define the `Wand` struct which confirm to `Weapon` protocol
// - the `effectPoints` should be 30

struct Wand: Weapon {
    var effectPoints = 30
    var name = "Magician Wand"
    var description = "Has Damaged you"

    func attack<P>(_ player: P) where P: Player {
        if player.health > effectPoints {
            player.health -= effectPoints
            print("you have been casted by spell by \(name) " + description)
        } else {
            print("you have been killed")
        }
    }
}

// 10. Define the `HealthPotion` struct which confirm to `Potion` protocol
// - the `effectPoints` should be 20

struct HealthPotion: Potion {
    var effectPoints = 20
    var name = "Healing Potion"
    var description = "you have healed yourself"

    func splash<P>(_ player: P) where P: Player {
        if player.health > effectPoints {
            player.health += effectPoints
            print(description)
        } else {
            print("you have full health and can't use Heal")
        }
    }
}

// 11. Define the `PoisonPotion` struct which confirm to `Potion` protocol
// - the `effectPoints` should be 20

struct PoisonPotion: Potion {
    var effectPoints = 20
    var name = "Poison Potion"
    var description = "you have been poisoned by "

    func splash<P>(_ player: P) where P: Player {
        if player.health > effectPoints {
            player.health -= effectPoints
            print(description + name)
        } else {
            print("you have been killed")
        }
    }
}

// 12. Define the `Warrior` class which confirm to `Player` protocol
// - the `health` should be 100

class Warrior: Player {
    var name: String
    var health: Int
    var chest: Chest
    
    init(name: String, health: Int, chest: Chest) {
        self.name = name
        self.health = health
        self.chest = chest
    }

    func attack<P>(_ player: P) where P: Player {
        for item in chest.items where item is Sword {
            if let weapon = item as? Weapon {
                weapon.attack(self)
            }
        }
    }

    func splash<P>(_ player: P) where P: Player {
        for item in chest.items where item is PoisonPotion {
            if let Potion = item as? PoisonPotion {
                Potion.splash(self)
            }
        }
    }

    func heal() {
        for item in chest.items where item is HealthPotion {
            if let Potion = item as? HealthPotion {
                Potion.splash(self)
            }
        }
    }
}

// 13. Define the `Wizard` class which confirm to `Player` protocol
// - the `health` should be 100

class Wizard: Player {
    var name: String

    var health: Int

    var chest: Chest

    init(name: String, health: Int, chest: Chest) {
        self.name = name
        self.health = health
        self.chest = chest
    }

    func attack<P>(_ player: P) where P: Player {
        for item in chest.items where item is Wand {
            if let weapon = item as? Weapon {
                weapon.attack(self)
            }
        }
    }

    func splash<P>(_ player: P) where P: Player {
        for item in chest.items where item is PoisonPotion {
            if let Potion = item as? PoisonPotion {
                Potion.splash(self)
            }
        }
    }

    func heal() {
        for item in chest.items where item is HealthPotion {
            if let Potion = item as? HealthPotion {
                Potion.splash(self)
            }
        }
    }
}

// use the following code to demonstrate the usage of your solution:
let warrior = Warrior(name: "Aragon", health: 100, chest: Chest(items: []))
let wizard = Wizard(name: "Gandalf", health: 100, chest: Chest(items: []))

// Add items to Warrior's chest
warrior.chest.items.append(Sword())
warrior.chest.items.append(HealthPotion())
warrior.chest.items.append(PoisonPotion())

// Add items to Wizard's chest
wizard.chest.items.append(Wand())
wizard.chest.items.append(HealthPotion())
wizard.chest.items.append(PoisonPotion())

// Simulating a battle
print("Initial Health - Warrior: \(warrior.health), Wizard: \(wizard.health)")
wizard.attack(warrior)
warrior.splash(wizard)
warrior.heal()
print("After Battle - Warrior: \(warrior.health), Wizard: \(wizard.health)")
