//
//  Shows.swift
//  TV_Shows_Project2
//
//  Created by Jonathan Messiha on 10/25/24.
//

import Foundation
import SwiftUI


/// Shows struct with each show component/variable
struct Shows : Codable, Identifiable, Hashable {
    var id = UUID()
    var name: String
    var rating: Double
    var numSeasons: Int
    var platform: String
    var watched: Bool
    var personalRating: Double?
}
