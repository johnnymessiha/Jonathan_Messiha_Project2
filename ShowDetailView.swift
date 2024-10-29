//
//  ShowDetailView.swift
//  TV_Shows_Project2
//
//  Created by Jonathan Messiha on 10/26/24.
//

import Foundation
import SwiftUI


struct ShowDetailView: View {
    
    /// Binding property allows the view to modify shows
    @Binding var show: Shows
    /// ObservedObject property gives access to ShowQueue
    @ObservedObject var showQueue: ShowQueue
    /// State property tracks watch status for each show
    @State private var watchedStatus: Bool = false
    /// State property tracks personal rating for each show
    @State private var personalRating: Double = 0.0
    
    var body: some View {
        Form {
            /// Display all of the shows details (name/rating/seasons/platform)
            Section(header: Text("Show Details")) {
                Text(show.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Rating: \(show.rating, specifier: "%.1f")")
                    .font(.title2)
                Text("Seasons: \(show.numSeasons)")
                    .font(.title2)
                Text("Platform: \(show.platform)")
                    .font(.title3)
                    .foregroundColor(.secondary)
            }
            
            /// Toggle for user to adjust if watched
            Section(header: Text("Watched")) {
                Toggle("Watched", isOn: $watchedStatus)
            }
            
            /// Slider bar for user to store their personal rating for future use
            Section(header: Text("Personal Rating")) {
                Text("Your Rating: \(personalRating, specifier: "%.1f")")
                    .font(.title2)
                Slider(value: $personalRating, in: 0...10, step: 0.5)
                    .padding(.horizontal)
            }
        }
        .navigationTitle("Show Details")
        
        /// Set watched status and personal rating to their values before displaying
        .onAppear {
            watchedStatus = show.watched
            personalRating = show.personalRating ?? 0.0
        }
        
        /// Change values based on toggle selection
        .onDisappear {
            show.watched = watchedStatus
            show.personalRating = personalRating
            
            /// If statement to display a check mark if the user has watched the show
            if watchedStatus {
                if !show.name.contains("✅") {
                    show.name += " ✅"
                }
            } else {
                show.name = show.name.replacingOccurrences(of: " ✅", with: "")
            }
        }
    }
}


/// Preview to check ShowDetailView easier
struct ShowDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ShowDetailView(show: .constant(
            Shows(name: "Breaking Bad", rating: 9.5, numSeasons: 5, platform: "AMC", watched: true, personalRating: 9.0)
        ), showQueue: ShowQueue())
    }
}
