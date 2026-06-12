////
////  ContactView.swift
////  ChatApp
////
////  Created by Houleng Ly on 10/6/26.
////
//
//import SwiftUI
//import CoreLocation
//
//struct ContactView: View {
//    @StateObject private var monitor = LocationMonitor()
//
//        var body: some View {
//            VStack(spacing: 24) {
//
//                Image(systemName: monitor.isInOffice ? "building.2.fill" : "figure.walk")
//                    .font(.system(size: 64))
//                    .foregroundStyle(monitor.isInOffice ? .green : .secondary)
//                    .animation(.spring, value: monitor.isInOffice)
//
//                Text(monitor.status)
//                    .font(.headline)
//                    .multilineTextAlignment(.center)
//                
//                if !monitor.isMonitoring {
//                    Button("Start monitoring") {
//                        Task { await monitor.startMonitoring() }
//                    }
//                    .buttonStyle(.borderedProminent)
//                }else {
//                    Button("Stop") {
//                        monitor.stopMonitoring()
//                    }
//                    .buttonStyle(.bordered)
//                    .tint(.red)
//                }
//
//            }
//            .padding()
//            .task {
//                await monitor.startMonitoring() 
//            }
//        }
//        
//}
