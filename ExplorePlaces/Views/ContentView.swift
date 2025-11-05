//
//  ContentView.swift
//  ExplorePlaces
//
//  Created by Dhruv Rasikbhai Jivani on 10/30/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = DestinationViewModel()
    @Namespace private var animation // For smooth grid/list transitions
    
    let gridColumns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                // MARK: - Animated Gradient Background
                LinearGradient(
                    colors: [.teal.opacity(0.25), .blue.opacity(0.25), .purple.opacity(0.25)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                .blur(radius: 20)
                .animation(.easeInOut(duration: 3).repeatForever(autoreverses: true), value: viewModel.showGrid)
                
                VStack(spacing: 0) {
                    
                    // MARK: - Elegant Header
                    VStack(spacing: 6) {
                        Text("🌍 ExplorePlaces")
                            .font(.largeTitle.bold())
                            .foregroundStyle(LinearGradient(colors: [.teal, .blue], startPoint: .leading, endPoint: .trailing))
                            .shadow(color: .teal.opacity(0.3), radius: 8, x: 0, y: 3)
                        
                        Text("Discover the world, one place at a time")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 25))
                    .padding(.horizontal)
                    .padding(.top, 8)
                    .shadow(radius: 8)
                    
                    // MARK: - Main Scroll Content
                    ScrollView {
                        if viewModel.showGrid {
                            LazyVGrid(columns: gridColumns, spacing: 20) {
                                ForEach(viewModel.destinations) { destination in
                                    NavigationLink(destination: DestinationDetailView(viewModel: viewModel, destination: destination)) {
                                        DestinationCardView(destination: destination)
                                            .matchedGeometryEffect(id: destination.id, in: animation)
                                            .shadow(color: .teal.opacity(0.3), radius: 5, x: 0, y: 3)
                                            .scaleEffect(0.98)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding()
                            .transition(.asymmetric(insertion: .scale.combined(with: .opacity), removal: .opacity))
                        } else {
                            LazyVStack(spacing: 14) {
                                ForEach(viewModel.destinations) { destination in
                                    NavigationLink(destination: DestinationDetailView(viewModel: viewModel, destination: destination)) {
                                        HStack(spacing: 16) {
                                            Image(destination.imageName)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 90, height: 90)
                                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                                .shadow(radius: 5)
                                            
                                            VStack(alignment: .leading, spacing: 6) {
                                                Text(destination.name)
                                                    .font(.headline)
                                                    .foregroundColor(.primary)
                                                
                                                Text(destination.country)
                                                    .font(.subheadline)
                                                    .foregroundColor(.secondary)
                                            }
                                            
                                            Spacer()
                                            
                                            if destination.visited {
                                                Image(systemName: "checkmark.circle.fill")
                                                    .foregroundColor(.green)
                                            }
                                        }
                                        .padding(.horizontal)
                                        .padding(.vertical, 8)
                                        .background(
                                            RoundedRectangle(cornerRadius: 16)
                                                .fill(.ultraThinMaterial)
                                                .shadow(radius: 3)
                                        )
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.top, 10)
                            .padding(.horizontal)
                            .transition(.slide.combined(with: .opacity))
                        }
                    }
                    .animation(.spring(response: 0.5, dampingFraction: 0.8), value: viewModel.showGrid)
                }
                
                // MARK: - Floating Grid/List Toggle Button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                viewModel.showGrid.toggle()
                            }
                        } label: {
                            Image(systemName: viewModel.showGrid ? "list.bullet" : "square.grid.2x2.fill")
                                .font(.system(size: 22, weight: .semibold))
                                .padding()
                                .background(.ultraThinMaterial)
                                .clipShape(Circle())
                                .shadow(color: .teal.opacity(0.3), radius: 8, x: 0, y: 4)
                        }
                        .padding()
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}
