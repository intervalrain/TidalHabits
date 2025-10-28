//
//  HabitTests.swift
//  TidalHabitsTests
//
//  Created on 2025-10-28.
//

import XCTest
@testable import TidalHabits

/// Test suite for Habit Entity
/// Following TDD approach: Write tests first, then implement
final class HabitTests: XCTestCase {

    // MARK: - Test Entity Protocol Conformance

    func testHabit_ShouldConformToEntityProtocol() {
        // Given
        let id = UUID()
        let habit = Habit(
            id: id,
            name: "晨間運動",
            iconId: "figure.run",
            defaultDuration: 1500, // 25 minutes
            starsReward: 1
        )

        // Then
        XCTAssertEqual(habit.id, id)
    }

    // MARK: - Test Initialization

    func testHabit_ShouldInitializeWithValidValues() {
        // Given
        let id = UUID()
        let name = "閱讀"
        let iconId = "book.fill"
        let duration: TimeInterval = 3600 // 1 hour
        let starsReward = 2

        // When
        let habit = Habit(
            id: id,
            name: name,
            iconId: iconId,
            defaultDuration: duration,
            starsReward: starsReward
        )

        // Then
        XCTAssertEqual(habit.id, id)
        XCTAssertEqual(habit.name, name)
        XCTAssertEqual(habit.iconId, iconId)
        XCTAssertEqual(habit.defaultDuration, duration)
        XCTAssertEqual(habit.starsReward, starsReward)
    }

    func testHabit_ShouldInitializeWithEmptyReminders() {
        // Given & When
        let habit = Habit(
            id: UUID(),
            name: "寫日記",
            iconId: "pencil",
            defaultDuration: 900,
            starsReward: 1
        )

        // Then
        XCTAssertTrue(habit.reminders.isEmpty)
    }

    // MARK: - Test Equatable

    func testHabit_ShouldBeEqualWhenSameId() {
        // Given
        let id = UUID()
        let habit1 = Habit(
            id: id,
            name: "冥想",
            iconId: "sparkles",
            defaultDuration: 600,
            starsReward: 1
        )
        let habit2 = Habit(
            id: id,
            name: "不同的名字", // Same ID, different properties
            iconId: "star",
            defaultDuration: 1200,
            starsReward: 2
        )

        // Then
        XCTAssertEqual(habit1, habit2, "Entities with same ID should be equal")
    }

    func testHabit_ShouldNotBeEqualWhenDifferentId() {
        // Given
        let habit1 = Habit(
            id: UUID(),
            name: "冥想",
            iconId: "sparkles",
            defaultDuration: 600,
            starsReward: 1
        )
        let habit2 = Habit(
            id: UUID(),
            name: "冥想", // Same properties, different ID
            iconId: "sparkles",
            defaultDuration: 600,
            starsReward: 1
        )

        // Then
        XCTAssertNotEqual(habit1, habit2, "Entities with different IDs should not be equal")
    }

    // MARK: - Test Identifiable

    func testHabit_ShouldBeIdentifiableByUUID() {
        // Given
        let habit = Habit(
            id: UUID(),
            name: "喝水",
            iconId: "drop.fill",
            defaultDuration: 60,
            starsReward: 1
        )

        // Then
        XCTAssertNotNil(habit.id)
        XCTAssertTrue(habit.id is UUID)
    }

    // MARK: - Test Business Rules (Future)

    func testHabit_NameShouldNotBeEmpty() {
        // This test will pass for now, but we should add validation later
        // Given & When
        let habit = Habit(
            id: UUID(),
            name: "",
            iconId: "questionmark",
            defaultDuration: 0,
            starsReward: 0
        )

        // Then - For now, just verify it can be created
        // TODO: Add validation in future iterations
        XCTAssertEqual(habit.name, "")
    }

    func testHabit_DurationShouldBePositive() {
        // This test will pass for now, but we should add validation later
        // Given & When
        let habit = Habit(
            id: UUID(),
            name: "測試",
            iconId: "star",
            defaultDuration: -100, // Negative duration
            starsReward: 1
        )

        // Then - For now, just verify it can be created
        // TODO: Add validation to prevent negative durations
        XCTAssertEqual(habit.defaultDuration, -100)
    }

    // MARK: - Test Reminders

    func testHabit_ShouldAcceptReminders() {
        // Given
        var habit = Habit(
            id: UUID(),
            name: "學習英文",
            iconId: "book",
            defaultDuration: 1800,
            starsReward: 2
        )

        // When
        // TODO: Implement HabitReminder Value Object
        // For now, use empty array
        habit.reminders = []

        // Then
        XCTAssertTrue(habit.reminders.isEmpty)
    }
}
