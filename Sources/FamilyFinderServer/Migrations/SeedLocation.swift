//
//  SeedLocation.swift
//  FamilyFinderServer
//
//  Created by 上條蓮太朗 on 2025/04/30.
//

import Fluent

struct SeedLocation: AsyncMigration {
    func prepare(on database: any Database) async throws {
        let sampleLocation = Location(
            id: nil,
            userID: "user123",
            latitude: 35.6895,
            longitude: 139.6917
        )
        try await sampleLocation.save(on: database)
    }
    
    func revert(on database: any Database) async throws {
        try await Location.query(on: database)
            .filter(\.$userID == "user123")
            .delete()
    }
}
