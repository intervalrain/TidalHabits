//
//  LoggingBehavior.swift
//  TidalHabits
//
//  Created on 2025-10-29
//  Copyright © 2025 TidalHabits. All rights reserved.
//

import Foundation
import OSLog

/// Logging behavior that logs request execution and performance
///
/// Logs Command/Query execution time and results for monitoring
class LoggingBehavior<TRequest, TResponse>: IPipelineBehavior {
    private let logger: Logger

    init(logger: Logger = Logger(subsystem: "com.tidalhabits", category: "CQRS")) {
        self.logger = logger
    }

    func handleAsync(
        _ request: TRequest,
        next: @escaping (TRequest) async throws -> TResponse
    ) async throws -> TResponse {
        let requestName = String(describing: type(of: request))
        let startTime = Date()

        logger.info("⏱️ Executing \(requestName)")

        do {
            let response = try await next(request)
            let duration = Date().timeIntervalSince(startTime)

            logger.info("✅ \(requestName) completed in \(String(format: "%.2f", duration * 1000))ms")

            return response
        } catch {
            let duration = Date().timeIntervalSince(startTime)

            logger.error("❌ \(requestName) failed after \(String(format: "%.2f", duration * 1000))ms: \(error.localizedDescription)")

            throw error
        }
    }
}
