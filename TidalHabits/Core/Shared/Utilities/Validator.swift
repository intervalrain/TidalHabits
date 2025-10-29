//
//  Validator.swift
//  TidalHabits
//
//  Created on 2025-10-29
//  Copyright © 2025 TidalHabits. All rights reserved.
//

import Foundation

/// Common validation rules
///
/// Usage:
/// ```
/// try CommonValidator.validateEmail(email)
/// try CommonValidator.validateLength(name, min: 3, max: 50, fieldName: "Habit name")
/// ```
enum CommonValidator {
    /// Validation errors
    enum ValidationError: Error, LocalizedError {
        case emptyField(String)
        case invalidEmail(String)
        case tooShort(field: String, minLength: Int)
        case tooLong(field: String, maxLength: Int)
        case outOfRange(field: String, min: Int, max: Int)
        case invalidFormat(String)

        var errorDescription: String? {
            switch self {
            case .emptyField(let field):
                return "\(field) cannot be empty"
            case .invalidEmail(let email):
                return "\(email) is not a valid email address"
            case .tooShort(let field, let minLength):
                return "\(field) must be at least \(minLength) characters"
            case .tooLong(let field, let maxLength):
                return "\(field) must be at most \(maxLength) characters"
            case .outOfRange(let field, let min, let max):
                return "\(field) must be between \(min) and \(max)"
            case .invalidFormat(let message):
                return message
            }
        }
    }

    /// Validate that string is not empty
    /// - Parameters:
    ///   - value: String to validate
    ///   - fieldName: Field name for error message
    /// - Throws: ValidationError if empty
    static func validateNotEmpty(_ value: String, fieldName: String = "Field") throws {
        guard !value.isBlank else {
            throw ValidationError.emptyField(fieldName)
        }
    }

    /// Validate email format
    /// - Parameter email: Email to validate
    /// - Throws: ValidationError if invalid
    static func validateEmail(_ email: String) throws {
        guard email.isValidEmail else {
            throw ValidationError.invalidEmail(email)
        }
    }

    /// Validate string length
    /// - Parameters:
    ///   - value: String to validate
    ///   - min: Minimum length
    ///   - max: Maximum length
    ///   - fieldName: Field name for error message
    /// - Throws: ValidationError if out of range
    static func validateLength(
        _ value: String,
        min: Int? = nil,
        max: Int? = nil,
        fieldName: String = "Field"
    ) throws {
        if let min = min, value.count < min {
            throw ValidationError.tooShort(field: fieldName, minLength: min)
        }
        if let max = max, value.count > max {
            throw ValidationError.tooLong(field: fieldName, maxLength: max)
        }
    }

    /// Validate numeric range
    /// - Parameters:
    ///   - value: Value to validate
    ///   - min: Minimum value
    ///   - max: Maximum value
    ///   - fieldName: Field name for error message
    /// - Throws: ValidationError if out of range
    static func validateRange<T: Comparable>(
        _ value: T,
        min: T,
        max: T,
        fieldName: String = "Field"
    ) throws {
        guard value >= min && value <= max else {
            throw ValidationError.outOfRange(
                field: fieldName,
                min: min as? Int ?? 0,
                max: max as? Int ?? 0
            )
        }
    }

    /// Validate that value is positive
    /// - Parameters:
    ///   - value: Value to validate
    ///   - fieldName: Field name for error message
    /// - Throws: ValidationError if not positive
    static func validatePositive<T: Comparable & Numeric>(
        _ value: T,
        fieldName: String = "Field"
    ) throws {
        guard value > 0 else {
            throw ValidationError.invalidFormat("\(fieldName) must be positive")
        }
    }

    /// Validate that value is not negative
    /// - Parameters:
    ///   - value: Value to validate
    ///   - fieldName: Field name for error message
    /// - Throws: ValidationError if negative
    static func validateNonNegative<T: Comparable & Numeric>(
        _ value: T,
        fieldName: String = "Field"
    ) throws {
        guard value >= 0 else {
            throw ValidationError.invalidFormat("\(fieldName) cannot be negative")
        }
    }
}
