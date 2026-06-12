//
//  ConversationHistoryView.swift
//  Chat
//
//  Created by Houleng Ly on 30/5/26.
//

import SwiftUI
import EasyLogger

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
//            .scaleEffect(configuration.isPressed ? 1.05 : 1.0)
//            .animation(
//                .spring(
//                    response: 0.3,
//                    dampingFraction: 0.6
//                ),
//                value: configuration.isPressed
//            )
    }
}



struct ConversationHistoryView : View {
    @State private var selected = 0
    @State private var selectedTab = 0
    
    
    
    var conversations: [Conversation] = [
        
        // Pinned
        Conversation(
            name: "Saved Messages",
            avatars: ["saved"],
            lastMessage: "Flutter tips and tricks",
            lastMessageTime: .minutesAgo(2),
            isPinned: true,
            messageStatus: .read,
            conversationType: .personal
        ),
        
        Conversation(
            name: "Family Group",
            avatars: ["mom", "dad"],
            lastMessage: "Dad: Don't forget dinner tonight!",
            lastMessageTime: .minutesAgo(10),
            unreadCount: 5,
            isPinned: true,
            conversationType: .group
        ),

        // Online users
        Conversation(
            name: "Alice Johnson",
            avatars: ["alice"],
            lastMessage: "Can you send me the file?",
            lastMessageTime: .minutesAgo(25),
            unreadCount: 3,
            isOnline: true,
            messageStatus: .delivered
        ),
        Conversation(
            name: "Bob Smith",
            avatars: ["bob"],
            lastMessage: "Sure, see you tomorrow",
            lastMessageTime: .minutesAgo(45),
            isOnline: true,
            messageStatus: .read
        ),

        // Groups
        Conversation(
            name: "iOS Developers",
            avatars: ["dev1", "dev2"],
            lastMessage: "John: Anyone know SwiftUI layout tricks?",
            lastMessageTime: .hoursAgo(1),
            unreadCount: 12,
            conversationType: .group
        ),
        Conversation(
            name: "Work Team",
            avatars: ["work1", "work2"],
            lastMessage: "Sara: Meeting at 3pm",
            lastMessageTime: .hoursAgo(2),
            isMuted: true,
            conversationType: .group
        ),

        // Channels
        Conversation(
            name: "Tech News",
            avatars: ["technews"],
            lastMessage: "Apple announces new MacBook Pro",
            lastMessageTime: .hoursAgo(3),
            unreadCount: 28,
            conversationType: .channel
        ),

        // Regular chats
        Conversation(
            name: "Emma Wilson",
            avatars: ["emma"],
            lastMessage: "Haha that's so funny",
            lastMessageTime: .hoursAgo(5),
            messageStatus: .read
        ),
        Conversation(
            name: "David Lee",
            avatars: ["david"],
            lastMessage: "You: Let's catch up soon!",
            lastMessageTime: .daysAgo(1),
            messageStatus: .delivered
        ),
        Conversation(
            name: "Sophia Clark",
            avatars: ["sophia"],
            lastMessage: "Photo 📷",
            lastMessageTime: .daysAgo(2),
            unreadCount: 1
        ),
        Conversation(
            name: "Ryan Martinez",
            avatars: ["ryan"],
            lastMessage: "Voice message",
            lastMessageTime: .daysAgo(3),
            isMuted: true,
            messageStatus: .sent
        ),
        Conversation(
            name: "Olivia Brown",
            avatars: ["olivia"],
            lastMessage: "Sticker ",
            lastMessageTime: .daysAgo(5),
            messageStatus: .read
        )
    ]
    var body: some View {
        let data = EasyLogger.shared.toJSONString(conversations)
        EasyLogger.shared.debug("All Conversations List : <json>\(data ?? "N/A")<json>")
        EasyLogger.shared.warning("All Conversations List : <json>\(data ?? "N/A")<json>")
        EasyLogger.shared.error("All Conversations List : <json>\(data ?? "N/A")<json>")
        return NavigationStack {
            GeometryReader { geo in
                ZStack {
                    ScrollView {
                        LazyVStack {
                            ForEach(conversations){ conversation in
                                ConversationRowView(conversation)
                            }
                        }
                    }
                    .safeAreaInset(edge: .top, spacing: 20) {
                        FilterConversationTabView(geo.size.width)
                            .background(.ultraThinMaterial)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Edit") {}
                    }
                    ToolbarItem(placement: .principal) {
                        HStack(spacing: 25) {
                            overlappingAvatarsView
                            Text("Chats")
                                .font(.system(size: 18,weight: .semibold))
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        HStack(spacing:10) {
                            Button(action :{}) {
                                Image(systemName: "plus.arrow.trianglehead.clockwise")
                                
                            }
                            Button(action :{}) {
                                Image(systemName: "square.and.pencil")
                            }
                        }
                        .padding(.horizontal,10)
                    }
                }
            }
        }
    }
    
    private var overlappingAvatarsView: some View {
        let avatarSize = 32.0
        return ZStack(alignment: .leading) {
            VStack {
                Image("profile2")
                    .resizable()
                    .scaledToFill()
                    .frame(width: avatarSize, height: avatarSize)
                    .clipShape(Circle())
            }
            .padding(3)
            .background(.white)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(
                        LinearGradient(
                            colors: [Color(hex: "13A240"), Color(hex: "1D90E2")],
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 2
                    )
            )
                .offset(x: avatarSize/2 + 5)
            
            VStack {
                Image("profile1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: avatarSize, height: avatarSize)
                    .clipShape(Circle())
            }
            .padding(3)
            .background(.white)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(
                        LinearGradient(
                            colors: [Color(hex: "13A240"), Color(hex: "1D90E2")],
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 2
                    )
            )
        }
        .frame(width: 50)
    }
    
    
    
}






#Preview {
    ConversationHistoryView()
}
    
