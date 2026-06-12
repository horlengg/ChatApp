//
//  TableViewComstomize.swift
//  Chat
//
//  Created by Houleng Ly on 6/6/26.
//

import SwiftUI


struct BasicTabView: View {
    var body: some View {
        TabView {
            Text("Home")
                .tabItem {
                    Label("Chats", systemImage: "person.fill")
                }
            
            Text("Search")
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            Text("Profile")
                .tabItem {
                    Image("pf")
                        .renderingMode(.original)
                    Text("Profile")
                }
        }
    }
}

#Preview {
    BasicTabView()
}
