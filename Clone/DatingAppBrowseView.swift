import SwiftUI

struct DatingAppBrowseView: View {
    let profiles: [Profile]
    @State private var currentIndex = 0
    @Binding var likedProfiles: [Profile] // Add a binding for liked profiles

    var body: some View {
        VStack {
            if !profiles.isEmpty {
                GeometryReader { geometry in
                    ZStack(alignment: .bottom) {
                        Image(profiles[currentIndex % profiles.count].imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                            .cornerRadius(10)
                            .gesture(
                                DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
                                    .onEnded { value in
                                        if value.translation.width < 0 {
                                            self.swipeLeft()
                                        } else if value.translation.width > 0 {
                                            self.swipeRight()
                                        }
                                    }
                            )
                        LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
                            .frame(height: geometry.size.height / 7)

                        VStack {
                            
                            Spacer()
                            
                            VStack {
                                
                                // Text right above the buttons
                                Text(profiles[currentIndex % profiles.count].name)
                                    .font(.system(size: 50))
                                    .fontWeight(.bold)
                                    .padding()
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                // Buttons at the bottom
                                HStack {
                                    Button(action: {
                                        swipeLeft()
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 60, height: 60)
                                            .foregroundColor(.red)
                                    }

                                    Spacer() // This will push the buttons to the edges

                                    Button(action: {
                                        swipeRight()
                                    }) {
                                        Image(systemName: "heart.circle.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 60, height: 60)
                                            .foregroundColor(.green)
                                    }
                                }
                                .padding(.horizontal, 20)
                            }
                            .padding()
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .bottom)
                    }
                }
            } else {
                Text("No more profiles")
            }
        }
    }

    // Swipe functions...

    private func swipeLeft() {
        currentIndex = (currentIndex + 1) % profiles.count
    }

    private func swipeRight() {
        let currentProfile = profiles[currentIndex % profiles.count]
        likedProfiles.append(currentProfile) // Add current profile to liked profiles
        currentIndex = (currentIndex + 1) % profiles.count
    }
}


struct MessagesView: View {
    var body: some View {
        Text("Messages")
    }
}

struct UserProfileView: View {
    var body: some View {
        Text("User Profile")
    }
}

