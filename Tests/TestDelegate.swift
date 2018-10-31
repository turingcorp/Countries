import XCTest
@testable import Countries

class TestDelegate:XCTestCase {
    private var data:Data!
    private var catalog:Catalog!
    private var delegate:MockDelegate!
    
    override func setUp() {
        data = try! Data(contentsOf:Bundle(for:TestParser.self).url(forResource:"Countries", withExtension:"json")!)
        catalog = Catalog()
        delegate = MockDelegate()
        catalog.delegate = delegate
    }
    
    func testNotifyOnLoad() {
        let expect = expectation(description:String())
        delegate.onUpdated = { expect.fulfill() }
        catalog.load(data:data)
        waitForExpectations(timeout:1)
    }
}
