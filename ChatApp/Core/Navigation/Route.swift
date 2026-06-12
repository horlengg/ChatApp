//
//  Route.swift
//  Chat
//
//  Created by Houleng Ly on 30/5/26.
//


import SwiftUI
import CoreLocation

// MARK: Our route definitions
public enum Route: Hashable {
    case login
    case post
    case product
    case test
    case eWallet
}


// MARK: To conform the Route to Hashable so it can be in a NavPath.
// These rules help the NavigationView to determine if the incoming route
// is the same with where we're at now.
extension Route {
    public static func == (lhs: Route, rhs: Route) -> Bool {
        switch (lhs, rhs) {
//        case (.index, .index),
//             (.login, .login)
//            return true
//
//        case let (.savePicture(le), .savePicture(re)):
//            return le == re
//
//        case (.search, .search):
//            return false
            
        default:
            return false
        }
    }
}

// MARK: To conform the Route to Hashable so it can be in a NavPath.
extension Route {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .post:
            hasher.combine(0)
        case .login:
            hasher.combine(2)
            // If the route contains parameters, you do add extra hash to further
            // seperate each sessions if you want.
            //        case .search:
            //            hasher.combine(3)
            //        case .savePicture(let userId):
            //            hasher.combine(5)
            //            hasher.combine(userId)
            //        }
        case .product:
            hasher.combine(1)
        case .test:
            hasher.combine(3)
        
        case .eWallet:
            hasher.combine(4)
        }
    }
}

// MARK: - A enum list to blacklist the routes that we don't want for native
// Swipe Back Control
extension Route {
    public var allowsSwipeBack: Bool {
        switch self {
//        case .product:
//            return false
            
        // Everything else — allow
        default:
            return true
        }
    }
}
