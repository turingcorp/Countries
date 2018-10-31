import Foundation

protocol Order {
    func with(_ context:Catalog, countries:[Country]) -> [Country]
}
