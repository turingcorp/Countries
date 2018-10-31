import Foundation
import CoreLocation

public class Catalog {
    public var query = String() { didSet { update() } }
    public var location = CLLocation(latitude:0, longitude:0) { didSet { getDistances() ; update() } }
    public weak var delegate:Delegate?
    public internal(set) var countries = [Country]() { didSet { delegate?.countriesUpdated() } }
    var search:Search = NameSearch() { didSet { update() } }
    var order:Order = CloserOrder() { didSet { update() } }
    private var all = [Country]()
    
    public init() { }
    public func searchByName() { search = NameSearch() }
    public func searchByCapital() { search = CapitalSearch() }
    public func searchByLanguage() { search = LanguageSearch() }
    public func searchByRegion() { search = RegionSearch() }
    public func searchByCurrency() { search = CurrencySearch() }
    public func orderByCloser() { order = CloserOrder() }
    public func orderByFurther() { order = FurtherOrder() }
    public func orderByName() { order = NameOrder() }
    
    public func load(data:Data) {
        all = try! JSONDecoder().decode([Country].self, from:data)
        getDistances()
        update()
    }
    
    private func update() {
        var countries = [Country]()
        if query.isEmpty {
            countries = all
        } else {
            countries = search.query(query.lowercased(), countries:all)
        }
        countries = order.with(self, countries:countries)
        self.countries = countries
    }
    
    private func getDistances() {
        all.forEach { $0.distance = CLLocation(latitude:$0.latlng[0], longitude:$0.latlng[1]).distance(from:location) }
    }
}
