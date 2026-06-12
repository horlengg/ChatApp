//
//  ColorExtension.swift
//  SwiftUIApp
//
//  Created by Houleng Ly on 22/2/26.
//


import SwiftUI


extension Color {
    
    static let primaryColor = Color(red: 0.11, green: 0.118, blue: 0.2) // #1c1e33
    static let errorColor = Color(red: 1, green: 0.42, blue: 0.42) // #ff6b6b
    static let brandColor = Color(red: 0.09, green: 0.376, blue: 0.643) // #1760a4
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8) & 0xFF) / 255
        let b = Double(int & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }

    
}



