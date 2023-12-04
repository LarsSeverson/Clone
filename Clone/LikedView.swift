import SwiftUI
struct LikedView: View {
    let likedProfiles: [Profile]

    var body: some View {
        NavigationView {
            if likedProfiles.isEmpty {
                Text("Start swiping right to see who you have liked!")
                    .font(.headline)
                    .padding()
                    .navigationTitle("Liked Profiles")
            } else {
                List(likedProfiles, id: \.name) { profile in
                    NavigationLink(destination: ProfileView(profile: profile, isMatch: false, startChat: { _ in})) {
                        HStack {
                            Image(profile.imageNames[0])
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())

                            Text(profile.name)
                                .font(.headline)
                        }
                        .padding(.vertical, 8)
                    }
                }
                .navigationTitle("Liked Profiles")
            }
        }
    }
}
