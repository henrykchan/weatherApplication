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
        
        
        
//        guard var unwrappedCurrentForecast = currentForecast else{return}
        
        
        APIClient.getForecast(city: city) { (JSON, error) in
            
            
            
            guard let unwrappedJSON = JSON
                else {
                    completion (nil,error)
                    return
            }
            
            var currentForecast = Forecast(dictionary: unwrappedJSON)
            
            // Setting City Name
            if let cityName = unwrappedJSON["name"] as? String {
                currentForecast.cityName = cityName
                print(cityName)
                print(currentForecast.cityName)
            }
            
            // Setting temperature
            if let main = unwrappedJSON["main"] as? [String:Any] {
                // Setting current temperature
                if let currentTemp = main["temp"] as? Int {
                    print(currentTemp)
                    currentForecast.currentTemp = currentTemp
                    print("We're HEREEE!!!!!!!")
                    print(currentForecast.currentTemp as Any)
                    
                }
                
                // Setting high temperature
                if let maxTemp = main["temp_max"] as? Int {
                    currentForecast.highTemp = maxTemp
                    print(currentForecast.highTemp as Any)
                }
                
                // Setting low temperature
                if let minTemp = main["temp_min"] as? Int {
                    currentForecast.lowTemp = minTemp
                }
            }
            
           // Setting weather condition description
            if let weather = unwrappedJSON["weather"] as? [[String:Any]] {
                for weatherAttributes in weather{
                if let description = weatherAttributes["description"] as? String {
                    currentForecast.condition = description
                    print(currentForecast.condition as Any)
                }
                }
            }
            
            // Setting Wind Speed
            if let wind = unwrappedJSON["wind"] as? [String:Any] {
                if let windSpeed = wind["speed"] as? Int {
                    currentForecast.windSpeed = windSpeed
                    print(currentForecast.windSpeed as Any)
                }
            }
            
            completion(currentForecast,nil)
        }
    }
}
