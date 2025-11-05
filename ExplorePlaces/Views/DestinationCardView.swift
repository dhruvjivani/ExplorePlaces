//
//  DestinationCardView.swift
//  ExplorePlaces
//
//  Created by Dhruv Rasikbhai Jivani on 10/30/25.
//

import SwiftUI

struct DestinationCardView: View {
    let destination: Destination
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                Image(destination.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 160)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 4)
                
                if destination.visited {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(.green)
                        .padding(8)
                        .background(.ultraThinMaterial, in: Circle())
                        .padding(6)
                }
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(destination.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(destination.country)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal, 4)
    }
}
