import Foundation

protocol Coffee {
    var cost: Int { get }
}

class SimpleCoffee: Coffee {
    var cost: Int {
        return 10
    }
}

protocol CoffeeDecorator: Coffee {
    var base: Coffee { get }
    init(base: Coffee)
}

class Milk: CoffeeDecorator {
    let base: Coffee
    
    var cost: Int {
        return base.cost + 1
    }
    
    required init(base: Coffee) {
        self.base = base
    }
}

class Whip: CoffeeDecorator {
    let base: Coffee
    
    var cost: Int {
        return base.cost + 2
    }
    
    required init(base: Coffee) {
        self.base = base
    }
}

class Sugar: CoffeeDecorator {
    let base: Coffee
    
    var cost: Int {
        return base.cost + 1
    }
    
    required init(base: Coffee) {
        self.base = base
    }
}

let coffee = SimpleCoffee()
let coffeWithMilk = Milk(base: coffee)
let coffeWithMilkAndSugar = Sugar(base: Milk(base: coffee))
print(coffeWithMilk.cost)
print(coffeWithMilkAndSugar.cost)
