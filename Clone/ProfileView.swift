import SwiftUI

struct ProfileView: View {
    let profile: Profile
    let isMatch: Bool
    var startChat: (Profile) -> Void

    
    var body: some View {
        ScrollView {
            VStack {
                // Swipeable Image Gallery
                TabView {
                    ForEach(profile.imageNames, id: \.self) { imageName in
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                    }
                }
                .frame(height: 400) // Adjust height as needed
                .tabViewStyle(PageTabViewStyle())

                // User's Name, Age, and Bio
                Text("\(profile.name), \(profile.age)")
                    .font(.largeTitle)
                    .padding()

                Text(profile.bio)
                    .font(.body)
                    .padding()

                // Interests Section
                VStack(alignment: .leading) {
                    Text("Interests")
                        .font(.headline)
                        .padding(.bottom, 2)
                    ForEach(profile.interests, id: \.self) { interest in
                        Text("• \(interest)")
                            .font(.body)
                    }
                }
                .padding()

                // Message Button - Only if it's a match
                if isMatch {
                    Button("Send Message") {
                        startChat(profile)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
                    
                    
                }

                Spacer()
            }
        }
        .navigationTitle("\(profile.name)'s Profile")
    }
}
