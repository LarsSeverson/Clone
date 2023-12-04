import SwiftUI

struct BrowseView: View {
    let profiles: [Profile]
    @State private var currentIndex = 0
    @State private var showNotificationPopover = false
    @State private var showProfileInfo = false // State variable for toggling profile info
    @State private var currentImageIndex = 0
    @Binding var likedProfiles: [Profile]
    @State private var showSwipeAnimation = false
    @State private var animationIcon = "heart.fill" // Default icon, can be "heart.fill" or "xmark"
    @State private var filterDistance = 50.0 // Default distance
    @State private var showFilterView = false

    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 20) {
                    Text("Clone App")
                        .font(.system(size: 30)) // Set the font size as needed
                        .foregroundColor(.black)
                        .padding() // Remove any padding
                    Spacer()
                    Button(action: {
                        showNotificationPopover = true
                    }) {
                        Image(systemName: "bell.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                    }
                    .popover(isPresented: $showNotificationPopover) {
                        Text("No new notifications")
                            .font(.headline)
                            .padding()
                    }
                    Button(action: {
                        showFilterView.toggle()
                    }) {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                    }
                    .sheet(isPresented: $showFilterView) {
                        FilterView(distance: $filterDistance)
                    }
                    .padding(.horizontal, 10)
                }
                if !profiles.isEmpty {
                    GeometryReader { geometry in
                        ZStack(alignment: .bottom) {
                            // Displaying profile images
                            if currentImageIndex < profiles[currentIndex % profiles.count].imageNames.count {
                                let imageName = profiles[currentIndex % profiles.count].imageNames[currentImageIndex]
                                Image(imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: geometry.size.width, height: geometry.size.height)
                                    .clipped()
                                    .cornerRadius(10)
                                    .overlay(
                                        HStack {
                                            Button(action: {
                                                cycleImage(backward: true)
                                            }) {
                                                Color.clear
                                            }
                                            .frame(width: geometry.size.width / 2, height: geometry.size.height)
                                            
                                            Button(action: {
                                                cycleImage(backward: false)
                                            }) {
                                                Color.clear
                                            }
                                            .frame(width: geometry.size.width / 2, height: geometry.size.height)
                                        }
                                    )
                                    .gesture(
                                        DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
                                            .onEnded { value in
                                                if value.translation.width < 0 {
                                                    // Swipe left
                                                    self.swipeLeft()
                                                } else if value.translation.width > 0 {
                                                    // Swipe right
                                                    self.swipeRight()
                                                }
                                            }
                                    )
                            }
                            
                            LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
                                .frame(height: geometry.size.height / 7)
                            
                            VStack {
                                Spacer()
                                
                                VStack {
                                    HStack {
                                        Text(profiles[currentIndex % profiles.count].name + ", " +
                                             String(profiles[currentIndex % profiles.count].age))
                                            .font(.system(size: 35))
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                            .cornerRadius(10)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        Button(action: {
                                            showProfileInfo.toggle()
                                        }) {
                                            Image(systemName: "arrow.up.circle.fill")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 30, height: 30)
                                                .foregroundColor(.white)
                                        }
                                        .padding(.horizontal, 35)
                                    }
                                    HStack {
                                        Image(systemName: "mappin.and.ellipse") // Replace with your desired icon
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 15, height: 15) // Adjust size as needed
                                            .foregroundColor(.white)

                                        Text("1 mile away")
                                            .font(.system(size: 17)) // Adjust font size as needed
                                            .foregroundColor(.white)
                                        Spacer()
                                    }
                                    .padding(.leading, 10)
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
                                        
                                        Spacer()
                                        
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
                                if showProfileInfo {
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text("Age: \(profiles[currentIndex % profiles.count].age)")
                                        Text("Bio: \(profiles[currentIndex % profiles.count].bio)")
                                        Text("Interests: \(profiles[currentIndex % profiles.count].interests.joined(separator: ", "))")
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                    .background(Color.white.opacity(0.8))
                                    .cornerRadius(10)
                                }
                            }
                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .bottom)
                            
                            // Swipe animation view
                            if showSwipeAnimation {
                                Image(systemName: animationIcon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(animationIcon == "heart.fill" ? .green : .red)
                                    .opacity(showSwipeAnimation ? 1 : 0)
                                    .animation(.easeIn(duration: 0.5), value: showSwipeAnimation)
                            }
                        }
                    }
                } else {
                    Text("No more profiles")
                }
            }
        }
    }

    private func swipeLeft() {
        animateSwipe(isLike: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            currentIndex = (currentIndex + 1) % profiles.count
            currentImageIndex = 0
        }
    }

    private func swipeRight() {
        animateSwipe(isLike: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let currentProfile = profiles[currentIndex % profiles.count]
            likedProfiles.append(currentProfile)
            currentIndex = (currentIndex + 1) % profiles.count
            currentImageIndex = 0
        }
    }

    private func animateSwipe(isLike: Bool) {
        animationIcon = isLike ? "heart.fill" : "xmark"
        showSwipeAnimation = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            showSwipeAnimation = false
        }
    }
    private func cycleImage(backward: Bool) {
        let profileImages = profiles[currentIndex % profiles.count].imageNames
        if backward {
            currentImageIndex = (currentImageIndex - 1 + profileImages.count) % profileImages.count
        } else {
            currentImageIndex = (currentImageIndex + 1) % profileImages.count
        }
    }
}

