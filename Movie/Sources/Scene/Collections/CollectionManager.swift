//
//  CollectionManager.swift
//  Movie
//
//  Created by Олеся Лыжина on 22.01.2026.
//

import Foundation

struct MovieCollection: Codable {
    let id: UUID
    let name: String
    let iconName: String
}

final class CollectionManager {
    static let shared = CollectionManager()
    private let key = "user_movie_collections"
    
    func saveCollection(_ collection: MovieCollection) {
        var collections = loadCollections()
        collections.append(collection)
        if let encoded = try? JSONEncoder().encode(collections) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    func loadCollections() -> [MovieCollection] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode([MovieCollection].self, from: data) else {
            return [MovieCollection(id: UUID(), name: "Избранное", iconName: "1")]
        }
        return decoded
    }
    func deleteCollection(id: UUID) {
        var collections = loadCollections()
        collections.removeAll { $0.id == id }
        saveAll(collections)
    }
    func updateCollection(id: UUID, newName: String, newIcon: String) {
        var collections = loadCollections()
        if let index = collections.firstIndex(where: { $0.id == id }) {
            let updated = MovieCollection(id: id, name: newName, iconName: newIcon)
            collections[index] = updated
            saveAll(collections)
        }
    }
    private func saveAll(_ collections: [MovieCollection]) {
        if let encoded = try? JSONEncoder().encode(collections) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
}
