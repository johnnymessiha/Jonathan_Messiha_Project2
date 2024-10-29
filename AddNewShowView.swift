//
//  AddNewShowView.swift
//  TV_Shows_Project2
//
//  Created by Jonathan Messiha on 10/26/24.
//

import Foundation
import SwiftUI

struct AddNewShowView: View {
    
    /// ObservedObject allows showQueue to display newly added shows
    @ObservedObject var showQueue: ShowQueue
    /// Bing path variable links the view to the navigation stack
    @Binding var path: NavigationPath
    
    /// Initialized empty values
    @State private var name: String = ""
    @State private var rating: Double = 0.0
    @State private var numSeasons: Int = 1
    @State private var platform: String = ""
    @State private var watched: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            /// Ask user for show name of new show
            DataInput(title: "Show Name", userInput: $name)
            
            /// Rating slider for user to input new show's rating
            VStack(alignment: .leading) {
                Text("Rating: \(rating, specifier: "%.1f")")
                    .font(.headline)
                Slider(value: $rating, in: 0.0...10.0, step: 0.1)
                    .padding(.horizontal)
            }
            
            /// Slider for number of seasons
            VStack(alignment: .leading) {
                Text("Number of Seasons: \(numSeasons)")
                    .font(.headline)
                Slider(value: Binding(
                    get: { Double(numSeasons) },
                    set: { numSeasons = Int($0) }
                /// Set range between 1 and 20+ (reasonable range)
                ), in: 1...20, step: 1)
                    .padding(.horizontal)
            }
            
            /// Ask user for show's streaming platform
            DataInput(title: "Platform", userInput: $platform)
            
            /// Toggle for whether user has watched the new show
            Toggle("Seen", isOn: $watched)
                .padding(.horizontal)
            
            /// Button to add new show when all info in complete
            Button(action: addNewShow) {
                Text("Add Show")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
        }
        .navigationTitle("Add New Show")
        .padding(.top)
    }
    
    
    /// Function to add the new show
    func addNewShow() {
        let newShow = Shows(name: name, rating: rating, numSeasons: numSeasons, platform: platform, watched: watched)
        showQueue.shows.append(newShow)
        path.removeLast()
    }
}


/// struct to handle text input for new shows
struct DataInput: View {
    var title: String
    @Binding var userInput: String
    
    /// Format title and platform in the VStack
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            TextField("Enter \(title)", text: $userInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding()
    }
}
