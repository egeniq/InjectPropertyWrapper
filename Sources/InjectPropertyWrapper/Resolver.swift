//
//  Resolver.swift
//  
//
//  Created by Peter Verhage on 01/07/2019.
//

public protocol Resolver {
    func resolve<T>(_ type: T.Type) -> T
    func resolve<T>(_ type: T.Type, name: String) -> T
}
