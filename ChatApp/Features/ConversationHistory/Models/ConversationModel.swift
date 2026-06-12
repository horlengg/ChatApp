//
//  ConversationModel.swift
//  Chat
//
//  Created by Houleng Ly on 30/5/26.
//

import SwiftUI

class Conversation: Codable, Identifiable {
    let id: String
    let name: String
    let avatars: [String]        // supports 1 or 2 avatars (group)
    let lastMessage: String
    let lastMessageTime: Date
    let unreadCount: Int
    let isOnline: Bool
    let isPinned: Bool
    let isMuted: Bool
    let messageStatus: MessageStatus
    let conversationType: ConversationType
    
    enum MessageStatus: String, Codable {
        case sent       // single tick
        case delivered  // double tick
        case read       // double tick blue
    }
    
    enum ConversationType: String, Codable {
        case personal
        case group
        case channel
    }
    
    init(
        id: String = UUID().uuidString,
        name: String,
        avatars: [String],
        lastMessage: String,
        lastMessageTime: Date,
        unreadCount: Int = 0,
        isOnline: Bool = false,
        isPinned: Bool = false,
        isMuted: Bool = false,
        messageStatus: MessageStatus = .sent,
        conversationType: ConversationType = .personal
    ) {
        self.id = id
        self.name = name
        self.avatars = avatars
        self.lastMessage = lastMessage
        self.lastMessageTime = lastMessageTime
        self.unreadCount = unreadCount
        self.isOnline = isOnline
        self.isPinned = isPinned
        self.isMuted = isMuted
        self.messageStatus = messageStatus
        self.conversationType = conversationType
    }
}


