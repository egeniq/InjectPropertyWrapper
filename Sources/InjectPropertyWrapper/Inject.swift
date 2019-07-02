//
//  Inject.swift
//
//
//  Created by Peter Verhage on 01/07/2019.
//

@propertyWrapper
public struct Inject<Value> {
    public private(set) var value: Value
    
    public init() {
        guard let resolver = InjectSettings.resolver else {
            fatalError("Make sure InjectSettings.resolver is set!")
        }
        
        self.init(resolver: resolver)
    }
    
    public init(name: String) {
        guard let resolver = InjectSettings.resolver else {
            fatalError("Make sure InjectSettings.resolver is set!")
        }

        self.init(name: name, resolver: resolver)
    }

    public init(resolver: Resolver) {
        value = resolver.resolve(Value.self)
    }
    
    public init(name: String, resolver: Resolver) {
        value = resolver.resolve(Value.self, name: name)
    }
}
