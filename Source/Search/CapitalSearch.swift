import Foundation

class CapitalSearch:Search {
    func query(_ query:String, countries:[Country]) -> [Country] {
        return countries.filter{ $0.capital.lowercased().contains(query) }
    }
}
