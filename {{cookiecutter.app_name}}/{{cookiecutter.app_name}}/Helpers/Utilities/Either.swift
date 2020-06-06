//
//  Either.swift
//  {{cookiecutter.app_name}}
//
//  Copyright © {{cookiecutter.company_name}}. All rights reserved.
//

import Foundation

/// A type representing a choice between two values: left and right.
enum Either<A, B> {
    case left(A)
    case right(B)
    
    /// Create an `Either` value from a value.
    ///
    /// - Parameter left: A value.
    ///
    /// - Returns: An `Either` value.
    init(_ left: A) {
        self = .left(left)
    }
    
    /// Create an `Either` value from a value.
    ///
    /// - Parameter right: A value.
    ///
    /// - Returns: An `Either` value.
    init(_ right: B) {
        self = .right(right)
    }
}

// MARK: - Getters

extension Either {
    /// Get an optional left value out of an `Either` value.
    var left: A? {
        switch self {
        case .left(let left):
            return left
        case .right:
            return nil
        }
    }
    
    /// Get an optional right value out of an `Either` value.
    var right: B? {
        switch self {
        case .left:
            return nil
        case .right(let right):
            return right
        }
    }
}

// MARK: - Functions

extension Either {
    /// Invokes the `left` function if the value is left, otherwise invokes the `right`.
    ///
    /// - Parameters:
    ///   - left: A function taking a left value.
    ///   - right: A function taking a right value.
    ///
    /// - Returns: A value.
    func `if`<C>(left: (A) -> C, right: (B) -> C) -> C {
        switch self {
        case .left(let a):
            return left(a)
        case .right(let b):
            return right(b)
        }
    }
}
