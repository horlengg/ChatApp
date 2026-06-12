//
//  SwipeBackControll.swift
//  Chat
//
//  Created by Houleng Ly on 30/5/26.
//


// Reference: https://github.com/zjinhu/Brick_SwiftUI/blob/main/Sources/Brick/Tools/NavigationGesture.swift
// Reference: https://stackoverflow.com/a/79310808/15466075
import SwiftUI


#if os(iOS)
import UIKit

extension View {
    /// Enables smart swipe-back control based on Router state
    public func smartSwipeBackControl() -> some View {
        self.background(
            SwipeBackControllerSetup()
        )
    }
}

struct SwipeBackControllerSetup: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = SwipeBackSetupViewController
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        UIViewControllerType()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}

class SwipeBackSetupViewController: UIViewController {
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        
        // Find the navigation controller and set up our custom delegate
        if let navigationController = findNavigationController() {
            navigationController.interactivePopGestureRecognizer?.delegate = navigationController
        }
    }
    
    private func findNavigationController() -> UINavigationController? {
        var current: UIViewController? = self
        
        while let viewController = current {
            if let navController = viewController.navigationController {
                return navController
            }
            current = viewController.parent
        }
        return nil
    }
}

extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        // Basic check: need more than one view controller to go back
        guard viewControllers.count > 1 else { return false }
        
        // Check if the current route allows swipe-back using shared Router instance
        guard let router = Router.shared else {
            // Fallback to default behavior if router not found
            return true
        }
        
        // This is the code that allows us to blacklist pages for swipe back
        return router.canNavigateBack
    }
}
#endif
