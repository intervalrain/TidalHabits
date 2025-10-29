//
//  ValueObject.swift
//  TidalHabits
//
//  Created on 2025-10-29
//  Copyright © 2025 TidalHabits. All rights reserved.
//

import Foundation

/// Base class for Value Objects in the domain layer.
/// Value Objects are immutable and their equality is based on their properties.
///
/// Reference: amantinband/clean-architecture
class ValueObject<T: Equatable>: Equatable {
    let value: T

    init(_ value: T) throws {
        try Self.validate(value)
        self.value = value
    }

    /// Override this method in subclasses to provide custom validation logic.
    /// - Parameter value: The value to validate
    /// - Throws: DomainException.validationFailed if validation fails
    class func validate(_ value: T) throws {
        // Override in subclasses
    }

    static func == (lhs: ValueObject<T>, rhs: ValueObject<T>) -> Bool {
        return lhs.value == rhs.value
    }
}