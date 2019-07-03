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
        
        // there is no registered bool, but the optional mock object has declared its
        // injected properties as optional, so no error is thrown
        let boolObject = MockObjectOptional<Bool>()
        XCTAssertEqual(boolObject.value, nil)
        XCTAssertEqual(boolObject.namedValue, nil)

        // however, the non optional mock object does require all injected properties
        // to be non optional, so we expect an exception here
        expectFatalError(expectedMessage: "Could not resolve non-optional Bool") {
            let boolObject = MockObject<Bool>()
            XCTAssertEqual(boolObject.value, nil)
            XCTAssertEqual(boolObject.namedValue, nil)
        }
    }

    static var allTests = [
        ("testInject", testInject)
    ]
}
