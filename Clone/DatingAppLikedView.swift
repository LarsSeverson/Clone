//
//  DatingAppLikedView.swift
//  Clone
//
//  Created by Lars Severson on 11/27/23.
//
import SwiftUI

struct LikedProfilesView: View {
    // Assuming you have an array of liked profiles
    let likedProfiles: [Profile]

    var body: some View {
        NavigationView {
            List(likedProfiles, id: \.name) { profile in
                HStack {
                    Image(profile.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())

                    Text(profile.name)
                        .font(.headline)
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Liked Profiles")
        }
    }
}
