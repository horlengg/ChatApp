//
//  ConversationRowView.swift
//  Chat
//
//  Created by Houleng Ly on 30/5/26.
//

import SwiftUI

struct ConversationRowView : View {
    private var conversation: Conversation
    init(_ conversation: Conversation) {
        self.conversation = conversation
    }
    var body: some View {
        
        HStack {
            HStack(alignment:.center,spacing: 15) {
                
//                Image(systemName: "person.circle.fill")
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 50,height: 50)
                avatarView
                
                VStack(alignment:.leading,spacing:3) {
                    Text(conversation.name)
                        .font(.system(size: 16, weight: .semibold))
                    Text("Ly Houleng")
                        .font(.system(size: 14, weight: .medium))
                    Text(conversation.lastMessage)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.gray)
                }
                
            }
            Spacer()
            VStack {
                Text("Fri")
                if conversation.unreadCount > 0 {
                    Text(String(conversation.unreadCount))
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 20,height: 20)
                        .background(Color(hex: "1D90E2"))
                        .clipShape(Circle())
                }
                
            }
        }
        .padding(.horizontal,20)
        
    }
    
    @ViewBuilder
    private var avatarView: some View {
        ZStack(alignment: .bottomTrailing) {
//            Circle()
//                .fill(Color.blue.opacity(0.3))
//                .frame(width: 52, height: 52)
//                .overlay(
//                    Text(conversation.name.prefix(2).uppercased())
//                        .font(.title2.bold())
//                        .foregroundStyle(.blue)
//                )
            
            Image("profile2")
                .resizable()
                .frame(width: 50,height: 50)
                .scaledToFill()
                .clipShape(Circle())
            
            // Online indicator
            if conversation.isOnline {
                Circle()
                    .fill(Color.green)
                    .frame(width: 14, height: 14)
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
            }
        }
    }
        
}
