//
//  ValidationBehavior.swift
//  TidalHabits
//
//  Created on 2025-10-29
//  Copyright © 2025 TidalHabits. All rights reserved.
//

import Foundation

/// Validation behavior that executes validators before handler execution
///
/// Similar to amantinband's ValidationBehavior
/// Automatically validates Command/Query before processing
class ValidationBehavior<TRequest, TResponse>: IPipelineBehavior {
    private let validators: [IValidator]

    init(validators: [IValidator] = []) {
        self.validators = validators
    }

    func handleAsync(
        _ request: TRequest,
        next: @escaping (TRequest) async throws -> TResponse
    ) async throws -> TResponse {
        // Execute all validators
        var errors: [String] = []

        for validator in validators {
            if let validationErrors = validator.validate(request) {
                errors.append(contentsOf: validationErrors)
            }
        }

        // If validation failed, throw ApplicationException
        if !errors.isEmpty {
            throw ApplicationException.validationFailed(errors)
        }

        // Continue to next behavior/handler
        return try await next(request)
    }
}

// MARK: - Validator Protocol

/// Protocol for validators
protocol IValidator {
    /// Validate the request and return errors if any
    /// - Parameter request: The request to validate
    /// - Returns: Array of error messages, or nil if valid
    func validate(_ request: Any) -> [String]?
}
