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
    @State private var userMatches: [Profile] = [profiles[2], profiles[1]]
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
            
            MessagesView(conversations: conversations, matches: $userMatches)
                .tabItem {
                    Label("Messages", systemImage: "message.fill")
                }
            
            ProfileView(profile: userProfile, isMatch: false, startChat: { _ in})
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
