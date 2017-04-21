//
//  ForecastModel.swift
//  weatherApplication
//
//  Created by Henry Chan on 3/31/17.
//  Copyright © 2017 Henry Chan. All rights reserved.
//

import Foundation

struct Forecast {

    var currentTemp = Int()
    var highTemp = Int()
    var lowTemp = Int()
    var condition = String()
    var cityName = String()
    var windSpeed = Int()
    var weatherID = Int()
//    var cloud: Int?
//    var sunrise: Int?
//    var sunset: Int?
//    var humidity: Int?
    
    init(dictionary: [String:Any]) {
        
        if let currentTempDict = dictionary["temp"] as? Int {
            self.currentTemp = currentTempDict
        }
        
        if let highTempDict = dictionary["temp_max"] as? Int {
            self.highTemp = highTempDict
        }
        
        if let lowTempDict = dictionary["temp_min"] as? Int {
            self.lowTemp = lowTempDict
        }
        
        if let conditionDict = dictionary["description"] as? String {
            self.condition = conditionDict
        }
        
        if let cityNameDict = dictionary["name"] as? String {
            self.cityName = cityNameDict
        }
        
        if let windSpeedDict = dictionary["speed"] as? Int {
            self.windSpeed = windSpeedDict
        }
        
        if let weatherIDDict = dictionary["id"] as? Int {
            self.weatherID = weatherIDDict
        }
//        if let cloudDict = dictionary["cloud"] as? Int {
//            cloud = cloudDict
//        }
//        
//        if let sunriseDict = dictionary["sunrise"] as? Int {
//            sunrise = sunriseDict
//        }
//        
//        if let sunsetDict = dictionary["sunset"] as? Int {
//            sunset = sunsetDict
//        }
        
//        if let humidityDict = dictionary["humidity"] as? Int {
//            humidity = humidityDict
//        }
    }
}
