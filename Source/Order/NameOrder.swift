import Foundation

class NameOrder:Order {
    func with(_ context:Catalog, countries:[Country]) -> [Country] { return countries }
}
