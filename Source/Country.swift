import Foundation

public struct Country:Codable {
    public internal(set) var name = String()
    public internal(set) var capital = String()
    public internal(set) var region = String()
    public internal(set) var flag = String()
    public internal(set) var alpha2Code = String()
    public internal(set) var latlng = [Double]()
    public internal(set) var languages = [Language]()
    public internal(set) var currencies = [Currency]()
}
