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
            BrowseView(profiles: profiles, likedProfiles: $likedProfiles)
                .tabItem {
                    Label("Browse", systemImage: "flame.fill")
                }
            
            LikedView(likedProfiles: likedProfiles)
                .tabItem {
                    Label("Liked", systemImage: "heart.fill")
                }
            
            MessagesView(conversations: conversations)
                .tabItem {
                    Label("Messages", systemImage: "message.fill")
                }
            
            ProfileView(profile: userProfile)
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
