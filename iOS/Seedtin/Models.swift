import Foundation

struct SeedPacket: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var seedName: String
    var quantity: Int
    var viabilityYear: Int
    var source: String

    init(id: UUID = UUID(), seedName: String = "", quantity: Int = 0, viabilityYear: Int = 0, source: String = "") {
        self.id = id
        self.seedName = seedName
        self.quantity = quantity
        self.viabilityYear = viabilityYear
        self.source = source
    }
}
