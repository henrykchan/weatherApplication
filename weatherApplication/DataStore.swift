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
    
    func getFiveDayWeather(latitude: String, longitude: String, completion: @escaping ([Forecast]?, NSError?) -> Void ) {
        
        APIClient.getFiveDayForecast(latitude: latitude, longitude: longitude) { (JSON, error) in
            
            guard let unwrappedJSON = JSON
                else {
                    completion (nil,error)
                    return
            }
            
            var forecast = Forecast(dictionary: unwrappedJSON)
            var forecasts: [Forecast] = []
            
            guard let city = unwrappedJSON ["city"] as? [String:Any] else{return}
            
            if let cityName = city["name"] as? String {
                forecast.cityName = cityName
                print("cityName:\(forecast.cityName)")
                
                
            }
            
            
            guard let list = unwrappedJSON["list"] as? [[String:Any]] else{return}
            
            for eachTemp in list {
                
                if let temp = eachTemp["temp"] as? [String:Any] {
                    
                    if let dayTemp = temp["day"] as? Int {
                        let fahrenheit = self.convertToFahrenheit(temp: dayTemp)
                        forecast.currentTemp = fahrenheit
                    }
                    
                    if let maxTemp = temp["max"] as? Int {
                        let fahrenheit = self.convertToFahrenheit(temp: maxTemp)
                        forecast.highTemp = fahrenheit
                    }
                    
                    if let minTemp = temp["min"] as? Int {
                        let fahrenheit = self.convertToFahrenheit(temp: minTemp)
                        forecast.lowTemp = fahrenheit
                    }
                }
                
                if let windSpeed = eachTemp["speed"] as? Int {
                    forecast.windSpeed = windSpeed
//                    print("Wind:\(forecast.windSpeed)")
                }
                
                if let weather = eachTemp["weather"] as? [[String:Any]] {
                    
                    for weatherAttributes in weather {
                        
                        if let id = weatherAttributes["id"] as? Int {
                            forecast.weatherID = id
                        }
                        
                        if let description = weatherAttributes["description"] as? String {
                            forecast.condition = description
                        }
                    }
                }
                
                forecasts.append(forecast)
                
            }
            
//            forecasts.remove(at: 0)
        
            completion(forecasts, nil)
        }
    }
    
    // Function to convert kelvin to fahrenheit
    func convertToFahrenheit(temp: Int) -> Int {
        
        var convertedInt:Int = 0
        
        convertedInt = Int(temp * 9/5 - 460)
        
        return convertedInt
    }
}
