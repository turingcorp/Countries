import Foundation

public class Country:Decodable {
    public internal(set) var name = String()
    public internal(set) var flag = String()
    public internal(set) var population = 0
    public internal(set) var area = 0.0
    var alpha2Code = String()
    var region = String()
    var capital = String()
    var latlng = [Double]()
    var languages = [Language]()
    var currencies = [Currency]()
}
