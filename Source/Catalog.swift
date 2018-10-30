import Foundation

public class Catalog {
    public internal(set) var countries = [Country]()
    
    public func load(data:Data) {
        countries = try! JSONDecoder().decode([Country].self, from:data)
    }
}
