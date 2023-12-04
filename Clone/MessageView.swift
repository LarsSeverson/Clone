//
//  MessageView.swift
//  Clone
//
//  Created by Lars Severson on 11/30/23.
//

import SwiftUI

struct Message: Identifiable {
    let id = UUID()
    let senderName: String
    let text: String
    let timestamp: Date
}

struct Conversation {
    let profile: Profile
    var messages: [Message]
}

struct ConversationDetailView: View {
    @State private var newMessageText = ""
    @State var conversation: Conversation // Changed to @State for local demo

    var body: some View {
        VStack {
            List {
                ForEach(conversation.messages) { message in
                    HStack {
                        if message.senderName == "User" { // Adjust this condition based on your current user identification logic
                            Spacer()
                            messageBubble(for: message, color: .blue)
                        } else {
                            messageBubble(for: message, color: .gray)
                            Spacer()
                        }
                    }
                }
            }

            // Message input field and send button
            HStack {
                TextField("Type a message...", text: $newMessageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: CGFloat(30))

                Button("Send") {
                    sendMessage()
                }
                .disabled(newMessageText.isEmpty)
            }
            .padding()
        }
        .navigationTitle(conversation.profile.name)
    }

    private func sendMessage() {
        let newMessage = Message(senderName: "User", text: newMessageText, timestamp: Date())
        conversation.messages.append(newMessage)
        newMessageText = ""
    }

    private func messageBubble(for message: Message, color: Color) -> some View {
        Text(message.text)
            .padding()
            .background(color)
            .cornerRadius(10)
            .foregroundColor(.white)
    }
}


struct MessagesView: View {
    @State var conversations: [Conversation] // Hold the list of conversations
    @Binding var matches: [Profile] // Array of Profile objects for matches
    @State private var selectedConversation: Conversation? // For navigation

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("New Matches").font(.headline)) {
                    MatchesView(matches: matches, startChat: startChat)
                        .frame(height: 100)
                }

                // Messages Section
                Section(header: Text("Messages").font(.headline)) {
                    ForEach(conversations, id: \.profile.name) { conversation in
                        NavigationLink(destination: ConversationDetailView(conversation: conversation)) {
                            HStack {
                                Image(conversation.profile.imageNames.first ?? "")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())

                                VStack(alignment: .leading) {
                                    Text(conversation.profile.name)
                                        .font(.headline)
                                    Text(conversation.messages.last?.text ?? "")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Chats")

        }
    }

    private func startChat(with profile: Profile) {
        if let index = conversations.firstIndex(where: { $0.profile.name == profile.name }) {
            // Navigate to existing conversation
            selectedConversation = conversations[index]
        } else {
            // Create a new conversation and navigate
            let newConversation = Conversation(profile: profile, messages: [])
            conversations.append(newConversation)
            selectedConversation = newConversation
        }
        
        // Remove the profile from matches
        matches.removeAll { $0.name == profile.name }
    }

}


struct MatchesView: View {
    var matches: [Profile] // Your Profile data for matches
    var startChat: (Profile) -> Void // Callback function to start a chat

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(matches, id: \.name) { match in
                    NavigationLink(destination: ProfileView(profile: match, isMatch: true, startChat: startChat)) {
                        VStack {
                            Image(match.imageNames.first ?? "")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())
                            Text(match.name)
                                .font(.caption)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}


