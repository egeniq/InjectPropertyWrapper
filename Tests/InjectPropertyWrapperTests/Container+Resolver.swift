//
//  Container+Resolver.swift
//  
//
//  Created by Peter Verhage on 02/07/2019.
//

import Swinject
import InjectPropertyWrapper

extension Container: InjectPropertyWrapper.Resolver {
    public func resolve<T>(_ type: T.Type) -> T {
        return resolve(type)!
    }
    
    public func resolve<T>(_ type: T.Type, name: String) -> T {
        return resolve(type, name: name)!
    }
}
