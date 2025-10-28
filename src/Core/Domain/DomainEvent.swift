import Foundation

protocol DomainEvent {
    var occurredAt: Date { get }
    var eventId: UUID { get }
}

extension DomainEvent {
    var occurredAt: Date { Date() }
    var eventId: UUID { UUID() }
}