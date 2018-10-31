import Foundation

class CurrencySearch:Search {
    func query(_ query:String, countries:[Country]) -> [Country] {
        return countries.filter{ country -> Bool in
            return country.currencies.contains { $0.name.lowercased().contains(query) }
        }
    }
}
