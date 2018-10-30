import XCTest
@testable import Countries

class TestParser:XCTestCase {
    private var data:Data!
    private var catalog:Catalog!
    
    override func setUp() {
        data = try! Data(contentsOf:Bundle(for:TestParser.self).url(forResource:"Countries", withExtension:"json")!)
        catalog = Catalog()
    }
    
    func testParsing() {
        catalog.load(data:data)
        XCTAssertFalse(catalog.countries.isEmpty)
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
}
