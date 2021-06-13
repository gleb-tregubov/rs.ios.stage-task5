import Foundation

class StockMaximize {

    func countProfit(prices: [Int]) -> Int {
        var profit = 0
        
        for (index, currentPrice) in prices.enumerated() {
            if let bestDayOffer = prices.dropFirst(index + 1).max() {
                if currentPrice < bestDayOffer {
                    profit += bestDayOffer - currentPrice
                }
            }
        }
        
        return profit
    }
}
