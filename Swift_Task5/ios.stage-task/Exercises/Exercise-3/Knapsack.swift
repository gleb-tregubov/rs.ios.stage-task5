import Foundation

public typealias Supply = (weight: Int, value: Int)

public final class Knapsack {
    let maxWeight: Int
    let drinks: [Supply]
    let foods: [Supply]
    var maxKilometers: Int {
        findMaxKilometres()
    }
    
    init(_ maxWeight: Int, _ foods: [Supply], _ drinks: [Supply]) {
        self.maxWeight = maxWeight
        self.drinks = drinks
        self.foods = foods
    }
    
    func makeTable(array: [Supply]) -> [[Int]] {
        var table = Array(repeating: Array(repeating: 0, count: maxWeight + 1), count: array.count + 1)
        
        // Пробегаемся по suplies
        for i in 1...array.count {
            // Проблегаемся до maxWeight
            for j in 0...maxWeight {
                if array[i - 1].weight <= j { // table[i - 1][j] - prev max
                    table[i][j] = max(table[i - 1][j], array[i - 1].value + table[i - 1][j - array[i - 1].weight])
//                    table[i][j] = array[i - 1].value
                } else {
                    table[i][j] = table[i - 1][j]
                }
            }
        }
        
        return table
        
    }
    
    func findMaxKilometres() -> Int {
        let foodsTable = makeTable(array: self.foods)
        let drinksTable = makeTable(array: self.drinks)
        // нужен максимальный дистанц каждый раз в сравнении с предыдущим максимальным дистанцом
        // берем минимальный value между foods и drinks
        // сравнивая его с максимальным дистанцом
        return Array(0...maxWeight).reduce(0) { (res, index) -> Int in
            return max( res , min( foodsTable[self.foods.count][index] , drinksTable[self.drinks.count][maxWeight - index]))
        }
        
//        return -1
    }
}
