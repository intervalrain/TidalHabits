//
//  IPipelineBehavior.swift
//  TidalHabits
//
//  Created on 2025-10-29
//  Copyright © 2025 TidalHabits. All rights reserved.
//

import Foundation

/// Pipeline behavior for Command/Query processing
///
/// Similar to MediatR's IPipelineBehavior<TRequest, TResponse>
/// Allows cross-cutting concerns like validation, logging, caching
protocol IPipelineBehavior {
    associatedtype TRequest
    associatedtype TResponse

    /// Handle the request and call the next behavior in the pipeline
    /// - Parameters:
    ///   - request: The command or query
    ///   - next: The next behavior or handler in the pipeline
    /// - Returns: The response from the handler
    func handleAsync(
        _ request: TRequest,
        next: @escaping (TRequest) async throws -> TResponse
    ) async throws -> TResponse
}
