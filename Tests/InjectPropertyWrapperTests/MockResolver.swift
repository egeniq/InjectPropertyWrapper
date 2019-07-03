import protocol InjectPropertyWrapper.Resolver

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

    func resolve<T>(_ type: T.Type, name: String?) -> T? {
        return registry[key(type: type, name: name)] as? T
    }
}
