import XCTest
import CoreLocation
@testable import Countries

class TestOrder:XCTestCase {
    private var catalog:Catalog!
    
    override func setUp() {
        catalog = Catalog()
        catalog.load(data:try! Data(contentsOf:
            Bundle(for:TestSearch.self).url(forResource:"Countries", withExtension:"json")!))
    }
    
    func testName() {
        catalog.orderByName()
        XCTAssertEqual("Afghanistan", catalog.countries.first!.name)
        XCTAssertEqual("Zimbabwe", catalog.countries.last!.name)
    }
    
    func testFilterAndName() {
        catalog.query = "austr"
        catalog.orderByName()
        XCTAssertEqual(2, catalog.countries.count)
        XCTAssertEqual("Australia", catalog.countries.first!.name)
        XCTAssertEqual("Austria", catalog.countries.last!.name)
    }
    
    func testCloserNoLocation() {
        XCTAssertEqual(250, catalog.countries.count)
        XCTAssertEqual("United States Minor Outlying Islands", catalog.countries.first!.name)
        XCTAssertEqual("Kiribati", catalog.countries.last!.name)
    }
    
    func testCloser() {
        catalog.location = CLLocation(latitude:51, longitude:9)
        XCTAssertEqual(250, catalog.countries.count)
        XCTAssertEqual("Germany", catalog.countries.first!.name)
        XCTAssertEqual("New Zealand", catalog.countries.last!.name)
    }
    
    func testCloserAndName() {
        catalog.query = "austr"
        catalog.location = CLLocation(latitude:51, longitude:9)
        XCTAssertEqual(2, catalog.countries.count)
        XCTAssertEqual("Austria", catalog.countries.first!.name)
        XCTAssertEqual("Australia", catalog.countries.last!.name)
    }
    
    func testFurther() {
        catalog.orderByFurther()
        catalog.location = CLLocation(latitude:51, longitude:9)
        XCTAssertEqual(250, catalog.countries.count)
        XCTAssertEqual("New Zealand", catalog.countries.first!.name)
        XCTAssertEqual("Germany", catalog.countries.last!.name)
    }
}
