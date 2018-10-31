import Foundation

public class Catalog {
    public weak var delegate:Delegate?
    public internal(set) var countries = [Country]()
    public init() { }
    
    public func load(data:Data) {
        countries = try! JSONDecoder().decode([Country].self, from:data)
        delegate?.countriesUpdated()
    }
}
