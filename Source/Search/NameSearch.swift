import Foundation

class NameSearch:Search {
    func query(_ query:String, countries:[Country]) -> [Country] {
        return countries.filter{ $0.name.lowercased().contains(query) }
    }
}
