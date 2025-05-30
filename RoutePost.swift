//
//  RoutePost.swift
//  TimeChamps
//
//  Created by Vinicius Serpa on 26/05/25.
//

import Foundation
import CoreLocation

struct RoutePost: Codable {
    let name: String
    let distance: Double
    let bestTime: String
    let points: [Point]

    struct Point: Codable {
        let latitude: Double
        let longitude: Double
        let timestamp: Date
    }

    init(from route: Route) {
        self.name = route.name
        self.distance = route.distance
        self.bestTime = route.bestTime
        self.points = route.points.map {
            Point(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude, timestamp: $0.timestamp)
        }
    }
}
