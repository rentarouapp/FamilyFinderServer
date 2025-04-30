//
//  Location.swift
//  FamilyFinderServer
//
//  Created by 上條蓮太朗 on 2025/04/30.
//

import Vapor
import Fluent

final class Location: Model, Content, @unchecked Sendable {
    static let schema = "locations"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "user_id")
    var userID: String

    @Field(key: "latitude")
    var latitude: Double

    @Field(key: "longitude")
    var longitude: Double

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    init() {}

    init(id: UUID? = nil, userID: String, latitude: Double, longitude: Double) {
        self.id = id
        self.userID = userID
        self.latitude = latitude
        self.longitude = longitude
    }
}
