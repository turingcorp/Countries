import Foundation

class LanguageSearch:Search {
    func query(_ query:String, countries:[Country]) -> [Country] {
        return countries.filter{ country -> Bool in
            return country.languages.contains { $0.name.lowercased().contains(query) }
        }
    }
}
