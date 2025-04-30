//
//  LocationData.swift
//  FamilyFinderServer
//
//  Created by 上條蓮太朗 on 2025/04/29.
//

import Vapor

struct LocationData: Content {
    var userId: String
    var latitude: Double
    var longitude: Double
}
