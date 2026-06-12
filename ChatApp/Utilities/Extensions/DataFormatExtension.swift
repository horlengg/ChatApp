//
//  DataFormatExtension.swift
//  Chat
//
//  Created by Houleng Ly on 30/5/26.
//


import SwiftUI


extension Date {
    static func minutesAgo(_ minutes: Int) -> Date {
        Calendar.current.date(byAdding: .minute, value: -minutes, to: Date())!
    }
    static func hoursAgo(_ hours: Int) -> Date {
        Calendar.current.date(byAdding: .hour, value: -hours, to: Date())!
    }
    static func daysAgo(_ days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: -days, to: Date())!
    }
}
