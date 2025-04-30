//
//  LocationController.swift
//  FamilyFinderServer
//
//  Created by 上條蓮太朗 on 2025/04/30.
//

import Vapor
import Fluent

struct LocationController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let locations = routes.grouped("location")

        locations.get(":userID", use: getLocation)
        locations.post(use: createLocation)
    }

    func getLocation(req: Request) async throws -> Location {
        guard let userID = req.parameters.get("userID") else {
            throw Abort(.badRequest)
        }
        guard let location = try await Location.query(on: req.db)
            .filter(\.$userID == userID)
            .first()
        else {
            throw Abort(.notFound)
        }
        return location
    }

    func createLocation(req: Request) async throws -> HTTPStatus {
        let location = try req.content.decode(Location.self)
        try await location.save(on: req.db)
        return .created
    }
}
