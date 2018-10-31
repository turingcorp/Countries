import Foundation

protocol Search {
    func query(_ query:String, countries:[Country]) -> [Country]
}
