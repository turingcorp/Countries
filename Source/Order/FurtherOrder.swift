import Foundation

class FurtherOrder:Order {
    func with(_ context:Catalog, countries:[Country]) -> [Country] {
        return countries.sorted { $0.distance > $1.distance }
    }
}
