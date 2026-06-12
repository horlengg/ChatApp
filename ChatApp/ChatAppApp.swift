//
//  ChatAppApp.swift
//  ChatApp
//
//  Created by Houleng Ly on 7/6/26.
//

import SwiftUI

import EasyLogger


@main
struct ChatAppApp: App {
    
    init () {
        let LOG_SERVER_URI = Bundle.main.object(forInfoDictionaryKey: "LOG_SERVER_URI") as? String
        print("LOG_SERVER_URI = \(LOG_SERVER_URI)")
        EasyLogger.shared.initialize(LOG_SERVER_URI)
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .smartSwipeBackControl()
        }
        
    }
    
    private var isEnableLog: Bool {
        #if ENABLE_EASY_LOGGER
        return true
        #else
        return false
        #endif
    }
    
}
