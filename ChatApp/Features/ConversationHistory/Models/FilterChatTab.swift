//
//  FilterChatTab.swift
//  Chat
//
//  Created by Houleng Ly on 31/5/26.
//



struct FilterChatTab : Equatable {
    var name : String
    var id : String
    var unreadCount: Int
    
    static func == (lhs: FilterChatTab, rhs: FilterChatTab) -> Bool {
        return lhs.id == rhs.id
    }
}
