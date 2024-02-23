//
//  Date+Days.swift
//  DateScrollPicker
//
//  Created by Alberto Aznar de los Ríos on 13/11/2019.
//  Copyright © 2019 Alberto Aznar de los Ríos. All rights reserved.
//

import Foundation

extension Date {
    
    static func today() -> Date {
        let cal = NSCalendar.current
        let components = cal.dateComponents([.year, .month, .day], from: Date())
        let today = cal.date(from: components)
        return today!
    }
    
    func plain() -> Date {
        let cal = NSCalendar.current
        let components = cal.dateComponents([.year, .month, .day], from: self)
        let plain = cal.date(from: components)
        return plain!
    }
    
    func firstDateOfMonth() -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: components)!
    }
    
    func addDays(_ days: Int) -> Date? {
        let dayComponenet = NSDateComponents()
        dayComponenet.day = days
        let theCalendar = NSCalendar.current
        let nextDate = theCalendar.date(byAdding: dayComponenet as DateComponents, to: self)
        return nextDate
    }
    
    func addMonth(_ month: Int) -> Date? {
        let dayComponenet = NSDateComponents()
        dayComponenet.month = month
        let theCalendar = NSCalendar.current
        let nextDate = theCalendar.date(byAdding: dayComponenet as DateComponents, to: self)
        return nextDate
    }
    
    func isWeekend() -> Bool {
        return Calendar.current.isDateInWeekend(self)
    }
    
    static func getFormatTime12Hour(from: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let date = dateFormatter.date(from: from)
        dateFormatter.dateFormat = "h:mm a"
        if let date = date {
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    static func getFormatTime24Hour(from: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let date = dateFormatter.date(from: from)
        dateFormatter.dateFormat = "HH:mm"
        if let date = date {
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
}
