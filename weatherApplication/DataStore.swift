//
//  DataStore.swift
//  weatherApplication
//
//  Created by Henry Chan on 4/12/17.
//  Copyright © 2017 Henry Chan. All rights reserved.
//

import Foundation
import Alamofire


class DataStore {
    
    static let sharedInstance = DataStore()
    fileprivate init() {}
    

    // Function to get weather from JSON and returning a Forecast object
    func getWeather(city: String, completion: @escaping (Forecast?, NSError?) -> Void ) {
        
        var currentForecast:Forecast!
        
        APIClient.getForecast(city: city) { (JSON, error) in
            
            guard let unwrappedJSON = JSON
                else {
                    completion (nil,error)
                    return
            }
            
            // Setting City Name
            if let cityName = unwrappedJSON["name"] as? String {
                currentForecast.cityName = cityName
                print(cityName)
            }
            
            // Setting temperature
            if let main = unwrappedJSON["main"] as? [String:Any] {
                
                // Setting current temperature
                if let currentTemp = main["temp"] as? Int {
                    currentForecast.currentTemp = currentTemp
                }
                
                // Setting high temperature
                if let maxTemp = main["temp_max"] as? Int {
                    currentForecast.highTemp = maxTemp
                }
                
                // Setting low temperature
                if let minTemp = main["temp_min"] as? Int {
                    currentForecast.lowTemp = minTemp
                }
            }
            
           // Setting weather condition description
            if let weather = unwrappedJSON["weather"] as? [String:Any] {
                if let description = weather["description"] as? String {
                    currentForecast.condition = description
                }
            }
            
            // Setting Wind Speed
            if let wind = unwrappedJSON["wind"] as? [String:Any] {
                if let windSpeed = wind["speed"] as? Int {
                    currentForecast.windSpeed = windSpeed
                }
            }
        }
    }
}
