//
//  CloneView.swift
//  Clone
//
//  Created by Lars Severson on 11/27/23.
//

import SwiftUI

// Main ContentView with TabView
struct ContentView: View {
    @State private var likedProfiles = [Profile]() // State variable for liked profiles
    var body: some View {
        TabView {
            DatingAppBrowseView(profiles: profiles, likedProfiles: $likedProfiles)
                .tabItem {
                    Label("Browse", systemImage: "flame.fill")
                }
            
            LikedProfilesView(likedProfiles: likedProfiles)
                .tabItem {
                    Label("Liked", systemImage: "heart.fill")
                }
            
            MessagesView()
                .tabItem {
                    Label("Messages", systemImage: "message.fill")
                }
            
            UserProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}

// Dummy profiles for preview
let profiles = [
    Profile(imageName: "random1", name: "Alex"),
    Profile(imageName: "random2", name: "Sam"),
    Profile(imageName: "random3", name: "Jordan")
    // Add more profiles as needed
]

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
