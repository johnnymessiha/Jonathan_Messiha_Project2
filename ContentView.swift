//
//  ContentView.swift
//  TV_Shows_Project2
//
//  Created by Jonathan Messiha on 10/25/24.
//

import SwiftUI

struct ContentView: View {
    
    /// showQueue ObservedObject allows for view updates when changed
    @ObservedObject var showQueue: ShowQueue = ShowQueue()
    /// stackPath State variable to structure views
    @State private var stackPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $stackPath) {
            List {
                /// Loop to show each show in the showQueue
                ForEach($showQueue.shows, id: \.self) { $show in
                    NavigationLink(value: show) {
                        /// Call to ListItems to display shows
                        ListItems(show: show)
                    }
                }
                /// Calls to functions for deleting and editing order
                .onDelete(perform: deleteItems)
                .onMove(perform: moveItems)
            }
            /// Navigation Destination for ShowDetailView
            .navigationDestination(for: Shows.self) { show in
                if let index = showQueue.shows.firstIndex(of: show) {
                    ShowDetailView(show: $showQueue.shows[index], showQueue: showQueue)
                }
            }
            /// Navigation Destination for AddNewShowView
            .navigationDestination(for: String.self) { _ in
                AddNewShowView(showQueue: showQueue, path:$stackPath)
            }
            /// ContentView title and toolbar
            .navigationTitle(Text("My TV Show List"))
            .toolbar {
                /// Add Show feature in the top left corner
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(value: "Add Show") { Text("Add") }
                }
                /// Edit feature in the top right corner
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
    }
    
    /// Function to delete items
    func deleteItems(at offsets: IndexSet) {
        showQueue.shows.remove(atOffsets: offsets)
    }
    
    /// Function to move items
    func moveItems(from source: IndexSet, to destination: Int) {
        showQueue.shows.move(fromOffsets: source, toOffset: destination)
    }
}


/// struct for listing show items in the content view
struct ListItems: View {
    var show: Shows
    
    var body: some View {
        /// VStack to display show details
        VStack(alignment: .leading) {
            Text(show.name)
                .font(.headline)
            Text("⭐️ \(show.rating, specifier: "%.1f")")
                .font(.subheadline)
            Text("\(show.numSeasons) seasons")
                .font(.subheadline)
            Text("\(show.platform)")
                .font(.subheadline)
        }
        .padding(.vertical, 4)
    }
}


#Preview {
    ContentView()
}
