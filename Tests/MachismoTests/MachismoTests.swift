import XCTest
@testable import Machismo

final class MachismoTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Machismo().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
