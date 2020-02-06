//
//  Reusables.swift
//  NewsReader
//
//  Created by Natalija Krsnik on 05/02/2020.
//  Copyright © 2020 Natalija. All rights reserved.
//

import Foundation

class Reusables {
    func resolveImageUrl(_ urlString: String, _ fallbackUrlString: String) -> URL {
        //let urlStringWithoutParams: String = urlString.components(separatedBy: "?")[0]
        
        print("urlstring", urlString)
        if let url = URL(string: urlString) {
            print("default url", urlString)
            return url;
        } else {
            print("Fallback url using for ", urlString)
            return URL(string: fallbackUrlString)!
        }
    }
    
    func formatDate(_ date: String) -> String{
        if date == "" {  return "1970-01-01T00:00:00Z" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let timeSince: Date = dateFormatter.date(from: date)!
        
        let calendar = Calendar.current
        let now = Date()
        let intervals: NSCalendar.Unit = [.second, .minute, .hour, .day]
        
        let components = (calendar as NSCalendar).components(intervals, from: timeSince, to: now, options: [])
        
        var stringTime = ""
        
        if let day = components.day, day >= 2 {
            stringTime = "Since " + String(day) + "days"
            return stringTime
        }
        
        if let day = components.day, day >= 1 {
            stringTime = "yesterday"
            return stringTime
        }
        
        if let hour = components.hour, hour >= 2 {
            stringTime = "Since " + String(hour) + "hours"
            return stringTime
        }
        
        if let hour = components.hour, hour >= 1 {
            stringTime = "Since one hour"
            return stringTime
        }
        
        if let minute = components.minute, minute >= 2 {
            stringTime = "Since " + String(minute) + "minutes"
            return stringTime
        }
        
        if let minute = components.minute, minute >= 1 {
            stringTime = "Since one minute"
            return stringTime
        }
        if let second = components.second, second >= 2 {
            stringTime = "Since " + String(second) + "seconds"
            return stringTime
        }
        
        if let second = components.second, second >= 1 {
            stringTime = "Since one second"
            return stringTime
        }
        return stringTime
    }
    
    
    
}
