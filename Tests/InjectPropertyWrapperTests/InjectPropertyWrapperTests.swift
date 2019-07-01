import XCTest
@testable import InjectPropertyWrapper

class MockResolver: Resolver {
    public var registry = [String: Any?]()
    
    private func key(type: Any.Type, name: String? = nil) -> String {
        if let name = name {
            return key(type: type) + "#" + name
        } else {
            return String(describing: type)
        }
    }
    
    func register<T>(_ type: T.Type, name: String? = nil, value: T) {
        registry[key(type: type, name: name)] = value
    }

    func resolve<T>(_ type: T.Type) -> T {
        return registry[key(type: type)] as! T
    }
    
    func resolve<T>(_ type: T.Type, name: String) -> T {
        return registry[key(type: type, name: name)] as! T
    }
}

class MockObject<T> {
    @Inject var value: T
    @Inject(name: "named") var namedValue: T
}

final class InjectPropertyWrapperTests: XCTestCase {
    func testInject() {
        let resolver = MockResolver()
        InjectPropertyWrapper.resolver = resolver
        
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
