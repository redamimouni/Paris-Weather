//
//  Utils.swift
//  ParisWeather
//
//  Created by reda.mimouni on 20/07/2021.
//

import Foundation

extension Int {
    
    func timeIntervalChangeToTimeStr(dateFormat:String?) -> String {
        let timeInterval = TimeInterval(self)
        let date = NSDate(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter()
        if dateFormat == nil {
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        } else {
            formatter.dateFormat = dateFormat
        }
        return formatter.string(from: date as Date)
    }
}

