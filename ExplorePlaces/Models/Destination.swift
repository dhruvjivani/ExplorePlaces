//
//  Destination.swift
//  ExplorePlaces
//
//  Created by Dhruv Rasikbhai Jivani on 10/30/25.
//

import Foundation
import CoreLocation

struct Destination: Identifiable {
    let id = UUID()
    let name: String
    let country: String
    let description: String
    let latitude: Double
    let longitude: Double
    let imageName: String
    var visited: Bool = false
}


