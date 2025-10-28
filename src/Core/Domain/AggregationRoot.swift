import Foundation

protocol AggregationRoot: Entity {
    associatedtype Event: DomainEvent
    var domainEvents: [Event] { get set }

    mutating func addDomainEvent(_ event: Event)
    mutating func clearDomainEvents()
}

extension AggregationRoot {
    mutating func addDomainEvent(_ event: Event) {
        domainEvents.append(event)
    }

    mutating func clearDomainEvents() {
        domainEvents.removeAll()
    }
}
