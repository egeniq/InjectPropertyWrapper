//
//  FatalError.swift
//  
//
//  Created by Peter Verhage on 03/07/2019.
//
//  See https://marcosantadev.com/test-swift-fatalerror/
//

import Foundation


struct FatalErrorUtil {
    private static let defaultFatalErrorClosure = { Swift.fatalError($0, file: $1, line: $2) }
    static var fatalErrorClosure: (String, StaticString, UInt) -> Never = defaultFatalErrorClosure
    
    static func replaceFatalError(closure: @escaping (String, StaticString, UInt) -> Never) {
        fatalErrorClosure = closure
    }
    
    static func restoreFatalError() {
        fatalErrorClosure = defaultFatalErrorClosure
    }
}

func fatalError(_ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) -> Never {
    FatalErrorUtil.fatalErrorClosure(message(), file, line)
}
