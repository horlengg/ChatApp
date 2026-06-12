//
//  HomeView.swift
//  Chat
//
//  Created by Houleng Ly on 31/5/26.
//

import SwiftUI
import EasyLogger

struct HomeView : View {
    
    @State private var activeTap = 2;
    @State private var isScaled = false
    @Namespace private var animationNamespace
    
    var body: some View {
        EasyLogger.shared.debug("activeTap = \(activeTap)",tag: "[HomeView]")
        return ZStack(alignment: .bottomTrailing) {
            Color.white.ignoresSafeArea()
            
            TabView(selection: $activeTap) {
                
                Tab("Contacts", systemImage: "person.crop.circle", value: 0) {
                    Text("Contacts")
                }
                
                Tab("Calls", systemImage: "phone", value: 1) {
                    Text("Calls")
                }
                
                Tab("Chats", systemImage: "ellipsis.message", value: 2) {
                    ConversationHistoryView()
                }
                
                Tab("Profile", image: "pf", value: 3) {
                    Text("Profile")
                }
                
                Tab(value : 4,role: .search) {
                    SearchView()
                } label: {
                    Label("Search", systemImage: "magnifyingglass")
                }
                
            }
            
        }
    }
    
    
}




//String, CaseIterable
enum ChatTab : String, CaseIterable {
    case contacts = "Contacts"
    case calls = "Calls"
    case chats = "Chats"
    case settings = "Settings"
    
    var icon : String {
        switch self {
        case .contacts: return "person.crop.circle.fill"
        case .calls: return "phone.fill"
        case .chats: return "message.fill"
        case .settings: return "profile1"
        }
    }
    
    var usingSystemIcon : Bool {
        switch self {
        case .settings: return false
        default : return true
        }
    }
    @ViewBuilder
    var displayer : some View {
        switch self {
        case .chats : ConversationHistoryView()
        default : EmptyView()
        }
    }
         
}


private struct TabItem: View {
    
    let tab: ChatTab
    let isSelected: Bool
    let namespace: Namespace.ID
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing:2) {
                if tab.usingSystemIcon {
                    Image(systemName: tab.icon)
                        .font(.system(size: 25))
                }else {
                    Image(tab.icon)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 28, height: 28)
                        .clipShape(Circle())
                }
                    
                
                Text(tab.rawValue)
                    .foregroundStyle(isSelected ? .primary : .secondary)
                    .fontWeight(isSelected ? .medium : .regular)
                    .font(.system(size: 14))
            }
            .padding(.vertical, 5)
            .frame(maxWidth: .infinity)
            
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




#Preview {
    HomeView()
}
