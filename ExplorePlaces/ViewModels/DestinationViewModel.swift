//
//  DestinationViewModel.swift
//  ExplorePlaces
//
//  Created by Dhruv Rasikbhai Jivani on 11/4/25.
//

import SwiftUI
import Combine   

class DestinationViewModel: ObservableObject {
    @Published var showGrid: Bool = false
    @Published var destinations: [Destination] = [
        Destination(name: "Paris", country: "France", description: "The City of Light, famous for art, fashion, and the iconic Eiffel Tower.", latitude: 48.8566, longitude: 2.3522, imageName: "paris"),
        Destination(name: "Tokyo", country: "Japan", description: "A vibrant mix of tradition and technology, from ancient temples to neon-lit skyscrapers.", latitude: 35.6762, longitude: 139.6503, imageName: "tokyo"),
        Destination(name: "New York", country: "USA", description: "The city that never sleeps – home to the Statue of Liberty and dazzling skyline.", latitude: 40.7128, longitude: -74.0060, imageName: "newyork"),
        Destination(name: "Rome", country: "Italy", description: "A timeless city steeped in history, architecture, and delicious cuisine.", latitude: 41.9028, longitude: 12.4964, imageName: "rome"),
        Destination(name: "Sydney", country: "Australia", description: "A coastal gem known for its Opera House, beaches, and sunny vibes.", latitude: -33.8688, longitude: 151.2093, imageName: "sydney")
    ]
    
    func toggleVisited(for destination: Destination) {
        if let index = destinations.firstIndex(where: { $0.id == destination.id }) {
            destinations[index].visited.toggle()
        }
    }
}
