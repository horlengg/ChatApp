////
////  AppDelegate.swift
////  ChatApp
////
////  Created by Houleng Ly on 9/6/26.
////
//
//import UIKit
//import CoreLocation
//
//
//class AppDelegate: NSObject, UIApplicationDelegate {
//
//    func application(
//        _ application: UIApplication,
//        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
//    ) -> Bool {
//        print("didFinishLaunchingWithOptions() : \(launchOptions)")
//        
//        LoggerService.sendLog("didFinishLaunchingWithOptions() : \(launchOptions)")
//        
//
//        // Handle OS relaunch after app was terminated due to a location event
//        if launchOptions?[.location] != nil {
//            print("App relaunched by OS due to location event")
//            LoggerService.sendLog("App relaunched by OS due to location event")
//            LocationManager.shared.startTracking()
//        }
//
//        return true
//    }
//    
//    
//    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        LoggerService.sendLog("[willFinishLaunchingWithOptions] \(String(describing: launchOptions))")
//        return true
//    }
//    
//    func applicationWillTerminate(_ application: UIApplication) {
//        LoggerService.sendLog(">>> applicationWillTerminate")
//        UserDefaults.standard.set(Date(), forKey: "app_terminated_at")
//    }
//    
//    
//    
//    
//}
