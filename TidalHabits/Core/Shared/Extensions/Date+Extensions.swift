//
//  Date+Extensions.swift
//  TidalHabits
//
//  Created on 2025-10-29
//  Copyright © 2025 TidalHabits. All rights reserved.
//

import Foundation

extension Date {
    /// Returns the start of the day (00:00:00)
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    /// Returns the end of the day (23:59:59)
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay) ?? self
    }

    /// Returns the start of the week (Sunday 00:00:00 by default)
    var startOfWeek: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        return calendar.date(from: components) ?? self
    }

    /// Returns the start of the month
    var startOfMonth: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: components) ?? self
    }

    /// Returns the end of the month
    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfMonth) ?? self
    }

    /// Check if date is today
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }

    /// Check if date is yesterday
    var isYesterday: Bool {
        return Calendar.current.isDateInYesterday(self)
    }

    /// Check if date is in the same week as another date
    /// - Parameter date: The date to compare with
    /// - Returns: True if in the same week
    func isSameWeek(as date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .weekOfYear)
    }

    /// Check if date is in the same month as another date
    /// - Parameter date: The date to compare with
    /// - Returns: True if in the same month
    func isSameMonth(as date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .month)
    }

    /// Add days to the date
    /// - Parameter days: Number of days to add
    /// - Returns: New date with added days
    func adding(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self) ?? self
    }

    /// Add hours to the date
    /// - Parameter hours: Number of hours to add
    /// - Returns: New date with added hours
    func adding(hours: Int) -> Date {
        return Calendar.current.date(byAdding: .hour, value: hours, to: self) ?? self
    }

    /// Add minutes to the date
    /// - Parameter minutes: Number of minutes to add
    /// - Returns: New date with added minutes
    func adding(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self) ?? self
    }

    /// Format date to string with given format
    /// - Parameter format: Date format string (e.g., "yyyy-MM-dd")
    /// - Returns: Formatted date string
    func toString(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
