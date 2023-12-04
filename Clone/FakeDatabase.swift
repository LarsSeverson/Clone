//
//  FakeDatabase.swift
//  Clone
//
//  Created by Lars Severson on 12/3/23.
//

import SwiftUI

let userProfile = Profile(
    imageNames: ["user1", "user2"],
    name: "Lars",
    age: 23,
    bio: "YOLO",
    interests: ["Skiing"]
)

// Dummy profiles for preview
let profiles = [
    Profile(
        imageNames: ["person1-1", "person1-2", "person1-3"],
        name: "Alice",
        age: 21,
        bio: "Looking for someone over 6' and has a boat",
        interests: ["Yacht"]
    ),
        
    Profile(
        imageNames: ["person2-1", "person2-2", "person2-3"],
        name: "Bob",
        age: 45,
        bio: "A 45 year old.",
        interests: ["Alchoholic"]
    ),
    Profile(
        imageNames: ["person3-1", "person3-2", "person3-3"],
        name: "Charlie",
        age: 22,
        bio: "Unfortunate",
        interests: ["Cat"]
    )
]

let conversations = [
    Conversation(profile: profiles[0], messages: [
        Message(senderName: "Alice", text: "Hello!", timestamp: Date()),
        Message(senderName: "User", text: "Hi there!", timestamp: Date())
    ]),
    // Add more conversations...
]
