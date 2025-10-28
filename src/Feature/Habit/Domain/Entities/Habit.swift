import Foundation

/// Habit Entity - Represents a user habit in the domain
/// Conforms to Entity protocol from Core.Domain
struct Habit: Entity {
    let id: UUID
    var name: String
    var iconId: String
    var defaultDuration: TimeInterval
    var starsReward: Int
    var reminders: [HabitReminder]

    init(
        id: UUID,
        name: String,
        iconId: String,
        defaultDuration: TimeInterval,
        starsReward: Int,
        reminders: [HabitReminder] = []
    ) {
        self.id = id
        self.name = name
        self.iconId = iconId
        self.defaultDuration = defaultDuration
        self.starsReward = starsReward
        self.reminders = reminders
    }
}

// MARK: - Value Objects

/// HabitReminder Value Object
/// Placeholder implementation - will be fully implemented in Issue #2
struct HabitReminder: Equatable {
    // Placeholder for now
    // TODO: Implement in Issue #2 - Habit Reminder Value Object
}
