import Foundation

class RegionSearch:Search {
    func query(_ query:String, countries:[Country]) -> [Country] {
        return countries.filter{ $0.region.lowercased().contains(query) }
    }
}
