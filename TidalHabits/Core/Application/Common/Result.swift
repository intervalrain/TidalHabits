//
//  Result.swift
//  TidalHabits
//
//  Created on 2025-10-29
//  Copyright © 2025 TidalHabits. All rights reserved.
//

import Foundation

/// Result type for operations that can succeed or fail.
///
/// Reference: amantinband/clean-architecture
/// Similar to .NET's Result<T> pattern
enum Result<TValue, TError: Error> {
    case success(TValue)
    case failure(TError)

    var isSuccess: Bool {
        if case .success = self { return true }
        return false
    }

    var isFailure: Bool {
        return !isSuccess
    }

    var value: TValue? {
        if case .success(let value) = self { return value }
        return nil
    }

    var error: TError? {
        if case .failure(let error) = self { return error }
        return nil
    }
}
