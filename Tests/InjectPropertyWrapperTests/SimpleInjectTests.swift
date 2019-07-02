import XCTest
import InjectPropertyWrapper

final class SimpleInjectTests: XCTestCase {
    func testInject() {
        let resolver = MockResolver()
        InjectSettings.resolver = resolver
        
        resolver.register(String.self, value: "a")
        resolver.register(String.self, name: "named", value: "b")
        resolver.register(Int.self, value: 123)
        resolver.register(Int.self, name: "named", value: 456)
        
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
