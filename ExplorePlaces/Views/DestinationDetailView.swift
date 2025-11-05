//
//  DestinationDetailView.swift
//  ExplorePlaces
//
//  Created by Dhruv Rasikbhai Jivani on 10/30/25.
//

import SwiftUI
import MapKit

struct DestinationDetailView: View {
    @ObservedObject var viewModel: DestinationViewModel
    var destination: Destination
    
    // Use new MapCameraPosition for iOS 17+
    @State private var cameraPosition: MapCameraPosition
    @State private var region: MKCoordinateRegion // for backward support
    
    init(viewModel: DestinationViewModel, destination: Destination) {
        self.viewModel = viewModel
        self.destination = destination
        
        let initialRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: destination.latitude, longitude: destination.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
        )
        
        _region = State(initialValue: initialRegion)
        _cameraPosition = State(initialValue: .region(initialRegion))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // MARK: - Destination Image
                Image(destination.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 220)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 5)
                    .padding(.horizontal)
                
                // MARK: - Destination Info
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(destination.name)
                            .font(.largeTitle.bold())
                            .foregroundColor(.teal)
                        
                        if destination.visited {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                    
                    Text(destination.country)
                        .font(.title3)
                        .foregroundColor(.secondary)
                    
                    Divider()
                    
                    Text(destination.description)
                        .font(.body)
                        .foregroundColor(.primary)
                        .lineSpacing(4)
                }
                .padding(.horizontal)
                
                // MARK: - Toggle Visited
                Toggle(isOn: Binding(
                    get: { destination.visited },
                    set: { _ in viewModel.toggleVisited(for: destination) }
                )) {
                    Text("Visited")
                        .font(.headline)
                }
                .toggleStyle(SwitchToggleStyle(tint: .teal))
                .padding(.horizontal)
                
                // MARK: - Map View
                if #available(iOS 17.0, *) {
                    Map(position: $cameraPosition) {
                        Annotation(destination.name,
                                   coordinate: CLLocationCoordinate2D(latitude: destination.latitude, longitude: destination.longitude)) {
                            Image(systemName: "mappin.circle.fill")
                                .foregroundColor(.teal)
                                .font(.title)
                        }
                    }
                    .frame(height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()
                } else {
                    // Fallback for iOS 16 and earlier
                    Map(coordinateRegion: $region, annotationItems: [destination]) { location in
                        MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)) {
                            Image(systemName: "mappin.circle.fill")
                                .foregroundColor(.teal)
                                .font(.title)
                        }
                    }
                    .frame(height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()
                }
            }
        }
        .navigationTitle(destination.name)
        .navigationBarTitleDisplayMode(.inline)
        .background(
            LinearGradient(colors: [.white, .teal.opacity(0.05)],
                           startPoint: .top,
                           endPoint: .bottom)
        )
    }
}
