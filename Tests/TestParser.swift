import XCTest
@testable import Countries

class TestParser:XCTestCase {
    private var data:Data!
    private var catalog:Catalog!
    
    override func setUp() {
        data = try! Data(contentsOf:Bundle(for:TestParser.self).url(forResource:"Countries", withExtension:"json")!)
        catalog = Catalog()
    }
    
    func testTotalCountries() {
        catalog.load(data:data)
        XCTAssertEqual(250, catalog.countries.count)
    }
    
    func testPerformance() {
        let expect = expectation(description:String())
        DispatchQueue.global(qos:.background).async {
            self.catalog.load(data:self.data)
            expect.fulfill()
        }
        waitForExpectations(timeout:1)
    }
    
    func testCountryInfo() {
        catalog.load(data:data)
        XCTAssertEqual("Germany", catalog.countries[84].name)
        XCTAssertEqual("https://restcountries.eu/data/deu.svg", catalog.countries[84].flag)
        XCTAssertEqual(81770900, catalog.countries[84].population)
        XCTAssertEqual(357114.0, catalog.countries[84].area)
        XCTAssertEqual("DE", catalog.countries[84].alpha2Code)
        XCTAssertEqual("Europe", catalog.countries[84].region)
        XCTAssertEqual("Berlin", catalog.countries[84].capital)
        XCTAssertEqual([51.0, 9.0], catalog.countries[84].latlng)
        XCTAssertEqual(1, catalog.countries[84].languages.count)
        XCTAssertEqual("German", catalog.countries[84].languages[0].name)
        XCTAssertEqual(1, catalog.countries[84].currencies.count)
        XCTAssertEqual("Euro", catalog.countries[84].currencies[0].name)
    }
}
