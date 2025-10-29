//
//  String+Extensions.swift
//  TidalHabits
//
//  Created on 2025-10-29
//  Copyright © 2025 TidalHabits. All rights reserved.
//

import Foundation

extension String {
    /// Trim whitespace and newlines
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// Check if string is empty or contains only whitespace
    var isBlank: Bool {
        return self.trimmed.isEmpty
    }

    /// Check if string is not empty and not blank
    var isNotBlank: Bool {
        return !isBlank
    }

    /// Check if string is a valid email
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }

    /// Check if string contains only letters
    var isAlphabetic: Bool {
        return !isEmpty && range(of: "[^a-zA-Z]", options: .regularExpression) == nil
    }

    /// Check if string contains only numbers
    var isNumeric: Bool {
        return !isEmpty && range(of: "[^0-9]", options: .regularExpression) == nil
    }

    /// Check if string contains only alphanumeric characters
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }

    /// Truncate string to specified length
    /// - Parameters:
    ///   - length: Maximum length
    ///   - trailing: Trailing string to add (default "...")
    /// - Returns: Truncated string
    func truncate(to length: Int, trailing: String = "...") -> String {
        if self.count > length {
            let endIndex = self.index(self.startIndex, offsetBy: length)
            return String(self[..<endIndex]) + trailing
        }
        return self
    }

    /// Capitalize first letter
    var capitalizedFirst: String {
        guard let first = self.first else { return self }
        return String(first).uppercased() + self.dropFirst()
    }

    /// Check if string has minimum length
    /// - Parameter length: Minimum length
    /// - Returns: True if string has at least the specified length
    func hasMinLength(_ length: Int) -> Bool {
        return self.count >= length
    }

    /// Check if string has maximum length
    /// - Parameter length: Maximum length
    /// - Returns: True if string has at most the specified length
    func hasMaxLength(_ length: Int) -> Bool {
        return self.count <= length
    }

    /// Convert string to Date
    /// - Parameter format: Date format string
    /// - Returns: Date if conversion succeeds, nil otherwise
    func toDate(format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
}
