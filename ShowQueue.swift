//
//  ShowQueue.swift
//  TV_Shows_Project2
//
//  Created by Jonathan Messiha on 10/25/24.
//

import Foundation
import SwiftUI


/// ShowQueue class with ObservableObject property wrapper so changes applied to UI
class ShowQueue: ObservableObject {
    
    /// Instantiate Shows object
    @Published var shows: [Shows]
    
    /// Initialize show array with sample data
    init(shows: [Shows] = [
        Shows(name: "Breaking Bad", rating: 9.5, numSeasons: 5, platform: "Netflix", watched: false, personalRating: 0.0),
        Shows(name: "Stranger Things", rating: 8.7, numSeasons: 4, platform: "Netflix", watched: false, personalRating: 0.0),
        Shows(name: "The Wire", rating: 9.3, numSeasons: 5, platform: "HBO", watched: false, personalRating: 0.0),
        Shows(name: "The Office", rating: 9.0, numSeasons: 9, platform: "Peacock", watched: false, personalRating: 0.0),
        Shows(name: "Game of Thrones", rating: 9.3, numSeasons: 8, platform: "HBO", watched: false, personalRating: 0.0)
    ]) {
        self.shows = shows
    }
}
