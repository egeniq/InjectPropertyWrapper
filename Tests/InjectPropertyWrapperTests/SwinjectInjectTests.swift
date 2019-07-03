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
        
        // disable logging, because we don't want to confuse the test output
        let loggingFunction = Container.loggingFunction
        Container.loggingFunction = nil
        
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
        
        Container.loggingFunction = loggingFunction
    }

    static var allTests = [
        ("testInject", testInject)
    ]
}
