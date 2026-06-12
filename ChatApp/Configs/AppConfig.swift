//
//  AppConfig.swift
//  Chat
//
//  Created by Houleng Ly on 30/5/26.
//




import SwiftUI


enum AppEnvironment: String {
    case uat
    case preprod
    case prod

    static var current: AppEnvironment {
        let value = Bundle.main.infoDictionary?["APP_ENV"] as? String ?? "uat"
        return AppEnvironment(rawValue: value) ?? .uat
    }
}
