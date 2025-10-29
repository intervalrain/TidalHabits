//
//  Logger.swift
//  TidalHabits
//
//  Created on 2025-10-29
//  Copyright © 2025 TidalHabits. All rights reserved.
//

import Foundation
import OSLog

/// Centralized logging utility using OSLog
///
/// Usage:
/// ```
/// AppLogger.info("User logged in", category: .auth)
/// AppLogger.error("Failed to save habit", category: .data, error: error)
/// ```
enum AppLogger {
    /// Log categories for different subsystems
    enum Category: String {
        case domain = "Domain"
        case application = "Application"
        case infrastructure = "Infrastructure"
        case presentation = "Presentation"
        case data = "Data"
        case network = "Network"
        case auth = "Auth"
        case general = "General"
    }

    private static let subsystem = "com.tidalhabits"

    /// Create logger for category
    private static func logger(for category: Category) -> Logger {
        return Logger(subsystem: subsystem, category: category.rawValue)
    }

    /// Log debug message
    /// - Parameters:
    ///   - message: The message to log
    ///   - category: Log category
    static func debug(_ message: String, category: Category = .general) {
        logger(for: category).debug("\(message)")
    }

    /// Log info message
    /// - Parameters:
    ///   - message: The message to log
    ///   - category: Log category
    static func info(_ message: String, category: Category = .general) {
        logger(for: category).info("\(message)")
    }

    /// Log warning message
    /// - Parameters:
    ///   - message: The message to log
    ///   - category: Log category
    static func warning(_ message: String, category: Category = .general) {
        logger(for: category).warning("\(message)")
    }

    /// Log error message
    /// - Parameters:
    ///   - message: The message to log
    ///   - category: Log category
    ///   - error: Optional error object
    static func error(_ message: String, category: Category = .general, error: Error? = nil) {
        if let error = error {
            logger(for: category).error("\(message): \(error.localizedDescription)")
        } else {
            logger(for: category).error("\(message)")
        }
    }

    /// Log critical message
    /// - Parameters:
    ///   - message: The message to log
    ///   - category: Log category
    ///   - error: Optional error object
    static func critical(_ message: String, category: Category = .general, error: Error? = nil) {
        if let error = error {
            logger(for: category).critical("\(message): \(error.localizedDescription)")
        } else {
            logger(for: category).critical("\(message)")
        }
    }
}
