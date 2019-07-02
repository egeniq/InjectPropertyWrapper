import XCTest

import InjectPropertyWrapper
import Swinject

final class SwinjectInjectTests: XCTestCase {
    func testInject() {
        let container = Container()
        container.register(String.self) { _ in "a" }
        container.register(String.self, name: "named") { _ in "b" }        
        container.register(Int.self) { _ in 123 }
        container.register(Int.self, name: "named") { _ in 456 }        

        InjectSettings.resolver = container
        
        let stringObject = MockObject<String>()
        XCTAssertEqual(stringObject.value, "a")
        XCTAssertEqual(stringObject.namedValue, "b")
        
        let intObject = MockObject<Int>()
        XCTAssertEqual(intObject.value, 123)
        XCTAssertEqual(intObject.namedValue, 456)     
    }

    static var allTests = [
        ("testInject", testInject)
    ]
}
