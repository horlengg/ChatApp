//
//  Router.swift
//  Chat
//
//  Created by Houleng Ly on 30/5/26.
//


import SwiftUI
import Combine

@MainActor
public class Router: ObservableObject {
    /// Shared instance for accessing from UIKit for swipe-back control later
    public static weak var shared: Router?
    
    /// The initial route
    private let initialRoute: Route

    /// The current navigation path
    @Published public var navPath = NavigationPath()
    
    /// The current active route
    @Published public var currentRoute: Route

    /// Whether the current route allows swipe-back gesture
    @Published public var canNavigateBack: Bool = true
    
    // MARK: - Initialization
    public init(initialRoute: Route = .post) {
        self.initialRoute = initialRoute
        self.currentRoute = initialRoute
        // Set shared reference for UIKit access
        Router.shared = self
    }
    
    // MARK: - Navigation Methods
    
    /// Navigates to the specified route
    /// - Parameter route: The route to navigate to
    public func navigate(to route: Route) {
        // Don't navigate if we're already on the same route
        // You must be confused with this part, I will explain it later ;)
        if currentRoute == route {
            navPath.append(route)
            return
        }
        
        // Update swipe-back permission based on route
        canNavigateBack = route.allowsSwipeBack
        
        // For index route, just update current route (tab state managed separately)
//        if case .index = route {
//            currentRoute = route
//            return
//        }
        
        // For all other routes, push onto the navigation stack
        currentRoute = route
        navPath.append(route)
    }
    
    /// Navigates back one level in the navigation stack
    public func navigateBack() {
        if !navPath.isEmpty {
            let currentCount = navPath.count
            navPath.removeLast()
            
            if currentCount == 1 {
                currentRoute = initialRoute
                canNavigateBack = initialRoute.allowsSwipeBack
            } else {
                canNavigateBack = true
            }
        }
    }
    
    /// Navigates back to the root of the navigation stack
    public func navigateToRoot() {
        if !self.navPath.isEmpty {
            self.navPath.removeLast(self.navPath.count)
        }
//        self.currentRoute = .index
//        self.canNavigateBack = Route.index.allowsSwipeBack
    }
    
    // MARK: - Swipe Back Control
    
    /// Manually override swipe-back gesture permission
    /// - Parameter canNavigateBack: Whether to allow swipe-back gesture
    public func setCanNavigateBack(_ canNavigateBack: Bool) {
        self.canNavigateBack = canNavigateBack
    }
}
