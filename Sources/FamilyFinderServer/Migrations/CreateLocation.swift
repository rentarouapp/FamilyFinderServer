//
//  CreateLocation.swift
//  FamilyFinderServer
//
//  Created by 上條蓮太朗 on 2025/04/30.
//

import Fluent

struct CreateLocation: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("locations")
            .id()
            .field("user_id", .string, .required)
            .field("latitude", .double, .required)
            .field("longitude", .double, .required)
            .field("created_at", .datetime)
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema("locations").delete()
    }
}
