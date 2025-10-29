//
//  UUID+Extensions.swift
//  TidalHabits
//
//  Created on 2025-10-29
//  Copyright © 2025 TidalHabits. All rights reserved.
//

import Foundation

extension UUID {
    /// Generate a new UUID (alias for UUID() for clarity)
    static func generate() -> UUID {
        return UUID()
    }

    /// Convert UUID to short string (first 8 characters)
    var short: String {
        return String(uuidString.prefix(8))
    }

    /// Check if UUID is empty (all zeros)
    var isEmpty: Bool {
        return self == UUID(uuidString: "00000000-0000-0000-0000-000000000000")
    }

    /// Create UUID from string, returns nil if invalid
    /// - Parameter string: UUID string
    /// - Returns: UUID if valid, nil otherwise
    static func from(string: String) -> UUID? {
        return UUID(uuidString: string)
    }
}
