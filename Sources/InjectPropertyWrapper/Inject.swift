//
//  Inject.swift
//
//
//  Created by Peter Verhage on 01/07/2019.
//


@propertyWrapper
public struct Inject<Value> {
    public let type = Value.self
    public let name: String?
    
    public private(set) var value: Value
    
    public init() {
        name = nil
        value = InjectConfig.resolver!.resolve(type)
    }
    
    public init(name: String) {
        self.name = name
        value = InjectConfig.resolver!.resolve(type, name: name)
    }
}