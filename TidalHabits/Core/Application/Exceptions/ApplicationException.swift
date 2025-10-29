//
//  ApplicationException.swift
//  TidalHabits
//
//  Created on 2025-10-29
//  Copyright © 2025 TidalHabits. All rights reserved.
//

import Foundation

/// Application layer exceptions.
///
/// Reference: amantinband/clean-architecture
enum ApplicationException: Error, LocalizedError {
    case validationFailed([String])
    case notFound(String)
    case unauthorized(String)

    var errorDescription: String? {
        switch self {
        case .validationFailed(let errors):
            return "Validation failed: \(errors.joined(separator: ", "))"
        case .notFound(let message):
            return "Not found: \(message)"
        case .unauthorized(let message):
            return "Unauthorized: \(message)"
        }
    }
}
