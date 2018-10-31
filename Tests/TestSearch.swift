import XCTest
@testable import Countries

class TestSearch:XCTestCase {
    private var catalog:Catalog!
    
    override func setUp() {
        catalog = Catalog()
        catalog.load(data:try! Data(contentsOf:
            Bundle(for:TestSearch.self).url(forResource:"Countries", withExtension:"json")!))
        catalog.orderByName()
    }
    
    func testNoQuery() {
        XCTAssertEqual(250, catalog.countries.count)
    }
    
    func testName() {
        catalog.query = "Germany"
        XCTAssertEqual(1, catalog.countries.count)
        XCTAssertEqual("Germany", catalog.countries[0].name)
    }
    
    func testNameLowercase() {
        catalog.query = "germany"
        XCTAssertEqual(1, catalog.countries.count)
        XCTAssertEqual("Germany", catalog.countries[0].name)
    }
    
    func testPartOfName() {
        catalog.query = "land"
        XCTAssertEqual(29, catalog.countries.count)
        XCTAssertEqual("Åland Islands", catalog.countries.first!.name)
        XCTAssertEqual("United Kingdom of Great Britain and Northern Ireland", catalog.countries.last!.name)
    }
    
    func testCapital() {
        catalog.query = "berlin"
        catalog.searchByCapital()
        XCTAssertEqual(1, catalog.countries.count)
        XCTAssertEqual("Germany", catalog.countries[0].name)
    }
    
    func testCapitalInversed() {
        catalog.searchByCapital()
        catalog.query = "berlin"
        XCTAssertEqual(1, catalog.countries.count)
        XCTAssertEqual("Germany", catalog.countries[0].name)
    }
    
    func testLanguage() {
        catalog.query = "eng"
        catalog.searchByLanguage()
        XCTAssertEqual(92, catalog.countries.count)
        XCTAssertEqual("American Samoa", catalog.countries.first!.name)
        XCTAssertEqual("Zimbabwe", catalog.countries.last!.name)
    }
    
    func testRegion() {
        catalog.query = "eri"
        catalog.searchByRegion()
        XCTAssertEqual(57, catalog.countries.count)
        XCTAssertEqual("Anguilla", catalog.countries.first!.name)
        XCTAssertEqual("Venezuela (Bolivarian Republic of)", catalog.countries.last!.name)
    }
    
    func testCurrency() {
        catalog.query = "pes"
        catalog.searchByCurrency()
        XCTAssertEqual(8, catalog.countries.count)
        XCTAssertEqual("Argentina", catalog.countries.first!.name)
        XCTAssertEqual("Uruguay", catalog.countries.last!.name)
    }
}
