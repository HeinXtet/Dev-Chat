//
//  Utils.swift
//  Dev-Chat
//
//  Created by HeinHtet on 8/19/18.
//  Copyright © 2018 HeinHtet. All rights reserved.
//

import Foundation

class Utils {
    
   static let instance = Utils()
    
    func convertTimestamp(serverTimestamp: Double) -> String {
        let x = serverTimestamp / 1000
        let date = NSDate(timeIntervalSince1970: x)
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        return formatter.string(from: date as Date)
    }
    func dayDifference(from interval : TimeInterval) -> String
    {
        let calendar = NSCalendar.current
        let date = NSDate(timeIntervalSince1970: interval) as Date
        if calendar.isDateInYesterday(date) { return "Yesterday" }
        else if calendar.isDateInToday(date) { return "Today" }
        else if calendar.isDateInTomorrow(date) { return "Tomorrow" }
        else {
            let startOfNow = calendar.startOfDay(for: Date())
            let startOfTimeStamp = calendar.startOfDay(for: date)
            let components = calendar.dateComponents([.day], from: startOfNow, to: startOfTimeStamp)
            let day = components.day!
            if day < 1 { return "\(abs(day)) days ago" }
            else { return "In \(day) days" }
        }
    }
    
}
