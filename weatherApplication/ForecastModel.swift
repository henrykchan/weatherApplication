//
//  ForecastModel.swift
//  weatherApplication
//
//  Created by Henry Chan on 3/31/17.
//  Copyright © 2017 Henry Chan. All rights reserved.
//

import Foundation

struct Forecast {
    
    var timezone: String?
    var time: Date?
    var timeString: String?
    var icon: String?
    var summary: String?
    var temperature: Double?
    var humidity: Double?
    
    init(dictionary: [String:Any]) {
        
        // Unwrapping time
        if let timeDictionary = dictionary["time"] as? Double {
            self.time = Date(timeIntervalSince1970: timeDictionary)
            
            // Date Formatter for title string
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh"
            
            if let unwrappedTime = self.time {
                self.timeString = dateFormatter.string(from: unwrappedTime)
            }
        }
        
        // Unwrapping summary
        if let summaryDictionary = dictionary["summary"] as? String {
            self.summary = summaryDictionary
        }
        
        // Unwrapping icon
        if let iconDictonary = dictionary["icon"] as? String {
            self.icon = iconDictonary
        }
        
        // Unwrapping temperature
        
        if let temperatureDictionary = dictionary["temperature"] as? Double {
            self.temperature = temperatureDictionary
        }
        
        if let temperatureHumidity = dictionary ["humidity"] as? Double {
            self.humidity = temperatureHumidity
        }
        
    }
}
