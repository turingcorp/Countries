import Foundation

public class Catalog {
    public var query = String() { didSet { update() } }
    public weak var delegate:Delegate?
    public internal(set) var countries = [Country]() { didSet { delegate?.countriesUpdated() } }
    var search:Search = NameSearch() { didSet { update() } }
    var order:Order = CloserOrder()
    private var all = [Country]() { didSet { update() } }
    
    public init() { }
    public func load(data:Data) { all = try! JSONDecoder().decode([Country].self, from:data) }
    public func searchByCapital() { search = CapitalSearch() }
    public func searchByLanguage() { search = LanguageSearch() }
    public func searchByRegion() { search = RegionSearch() }
    public func searchByCurrency() { search = CurrencySearch() }
    
    private func update() {
        if query.isEmpty {
            countries = all
        } else {
            countries = search.query(query.lowercased(), countries:all)
        }
    }
}
