//
//  DomainException.swift
//  TidalHabits
//
//  Created on 2025-10-29
//  Copyright © 2025 TidalHabits. All rights reserved.
//

import Foundation

/// Base error type for domain layer exceptions.
/// Represents errors that occur within the domain logic and business rules.
///
/// Similar to .NET's DomainException pattern.
enum DomainException: Error, LocalizedError {
    case validationFailed(String)
    case businessRuleViolation(String)
    case entityNotFound(String)
    case invalidOperation(String)
    case invalidState(String)

    var errorDescription: String? {
        switch self {
        case .validationFailed(let message):
            return "Validation failed: \(message)"
        case .businessRuleViolation(let message):
            return "Business rule violation: \(message)"
        case .entityNotFound(let message):
            return "Entity not found: \(message)"
        case .invalidOperation(let message):
            return "Invalid operation: \(message)"
        case .invalidState(let message):
            return "Invalid state: \(message)"
        }
    }
}
