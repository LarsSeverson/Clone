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
    var conversations: [Conversation]

    var body: some View {
        NavigationView {
            List(conversations, id: \.profile.name) { conversation in
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
            .navigationTitle("Messages")
        }
    }
}
