import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published var items: [SeedPacket] = []
    @Published var isPro: Bool = false

    /// Free tier allows this many entries. Seed data below is always fewer than this
    /// so a fresh install never opens straight into the paywall.
    static let freeLimit = 20

    private let fileName = "seedtin_items.json"

    private var fileURL: URL {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        if !FileManager.default.fileExists(atPath: dir.path) {
            try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        }
        return dir.appendingPathComponent(fileName)
    }

    init() {
        load()
    }

    func load() {
        guard let data = try? Data(contentsOf: fileURL),
              let decoded = try? JSONDecoder().decode([SeedPacket].self, from: data) else {
            items = Self.seedData()
            save()
            return
        }
        items = decoded
    }

    func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }

    var canAddMore: Bool {
        isPro || items.count < Self.freeLimit
    }

    @discardableResult
    func add(_ item: SeedPacket) -> Bool {
        guard canAddMore else { return false }
        items.append(item)
        save()
        return true
    }

    func update(_ item: SeedPacket) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx] = item
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: SeedPacket) {
        items.removeAll { $0.id == item.id }
        save()
    }

    static func seedData() -> [SeedPacket] {
        [
        SeedPacket(seedName: "Heirloom Tomato", quantity: 1, viabilityYear: 1, source: "Baker Creek"),
        SeedPacket(seedName: "Zinnia Mix", quantity: 2, viabilityYear: 2, source: "Local swap"),
        SeedPacket(seedName: "Sunflower", quantity: 3, viabilityYear: 3, source: "Seed Savers Exchange"),
        SeedPacket(seedName: "Heirloom Tomato", quantity: 4, viabilityYear: 4, source: "Baker Creek")
        ]
    }
}
