//
//  FilterConversationTabView.swift
//  Chat
//
//  Created by Houleng Ly on 31/5/26.
//

import SwiftUI
import OSLog


struct FilterConversationTabView: View {
    
    @State private var isScaled: Bool
    @State private var activeTap: FilterChatTab
    @Namespace private var animationNamespace
    private var size : CGFloat
    
    private let tabList = [
        FilterChatTab(name: "Alls", id: "all", unreadCount: 10),
        FilterChatTab(name: "Personals", id: "personal", unreadCount: 0),
        FilterChatTab(name: "Groups", id: "groups", unreadCount: 7),
        FilterChatTab(name: "APD Bank", id: "apdbanks", unreadCount: 5),
    ]
    
    init(_ size : CGFloat) {
        self.size = size
        self.isScaled = false
        self.activeTap = tabList.first!
    }
    
    var body: some View {
        return ZStack {
            VStack {
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach(tabList, id: \.id) { tab in
                                TabItem(
                                    tab: tab,
                                    isSelected: activeTap == tab,
                                    namespace: animationNamespace,
                                    onTap: {
                                        withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                                            activeTap = tab
                                            isScaled = true
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                                            withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                                                isScaled = false
                                            }
                                        }
                                    })
                            }
                        }
                        .padding(.vertical, 5)
//                        .padding(.horizontal, 20)
                    }
                    .frame(width: max(size, 40) - 40)
//                        .background(.blue)
                    
                }
            }
            .frame(width: size)
            .glassEffect()
        }
        .scaleEffect(isScaled ? 1.05 : 1.0)
        
    }
}

private struct TabItem: View {
    
    let tab: FilterChatTab
    let isSelected: Bool
    let namespace: Namespace.ID
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack {
                Text(tab.name)
                    .foregroundStyle(.primary)
                    .fontWeight(isSelected ? .semibold : .medium)
                    .font(.system(size: 16))
                
                if tab.unreadCount > 0 {
                    Text(String(tab.unreadCount))
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 20,height: 20)
                        .background(Color(hex: "1D90E2"))
                        .clipShape(Circle())
                }
                
            }
            .padding(.vertical, 10)
            .frame(minWidth: 140)
            
            
        }
        .buttonStyle(ScaleButtonStyle())
        .background {
            if isSelected {
                Capsule()
                    .fill(Color.gray.opacity(0.2))
                    .cornerRadius(1)
                    .matchedGeometryEffect(id: "activePill", in: namespace)
            }
        }
    }
}


//#Preview {
//    FilterConversationTabView()
//}
