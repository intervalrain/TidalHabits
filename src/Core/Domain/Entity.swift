import Foundation

protocol Entity: Identifiable, Equatable where ID == UUID {
    var id: UUID { get }
}

extension Entity {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
