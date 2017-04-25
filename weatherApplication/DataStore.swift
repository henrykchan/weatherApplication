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
    func getWeather(latitude: String, longitude: String, completion: @escaping (Forecast?, NSError?) -> Void ) {
        
        
        APIClient.getForecast(latitude: latitude, longitude: longitude) { (JSON, error) in
            
            
            
            guard let unwrappedJSON = JSON
                else {
                    completion (nil,error)
                    return
            }
            
            var currentForecast = Forecast(dictionary: unwrappedJSON)
            
            // Setting City Name
            if let cityName = unwrappedJSON["name"] as? String {
                currentForecast.cityName = cityName
            }
            
            // Setting temperature
            if let main = unwrappedJSON["main"] as? [String:Any] {
                // Setting current temperature
                if let currentTemp = main["temp"] as? Int {

                    let fahrenheit = self.convertToFahrenheit(temp: currentTemp)
                    currentForecast.currentTemp = fahrenheit
                }
                
                // Setting high temperature
                if let maxTemp = main["temp_max"] as? Int {
                    let fahrenheit = self.convertToFahrenheit(temp: maxTemp)
                    currentForecast.highTemp = fahrenheit
                }
                
                // Setting low temperature
                if let minTemp = main["temp_min"] as? Int {
                    let fahrenheit = self.convertToFahrenheit(temp: minTemp)
                    currentForecast.lowTemp = fahrenheit
                }
            }
            
           // Setting weather condition and icon
            if let weather = unwrappedJSON["weather"] as? [[String:Any]] {
                for weatherAttributes in weather{
                    
                    // Setting condition
                    if let description = weatherAttributes["description"] as? String {
                        currentForecast.condition = description

                    }
                    
                    if let id = weatherAttributes["id"] as? Int {
                        currentForecast.weatherID = id

                    }
                }
            }
            
            // Setting Wind Speed
            if let wind = unwrappedJSON["wind"] as? [String:Any] {
                if let windSpeed = wind["speed"] as? Int {
                    currentForecast.windSpeed = windSpeed

                }
            }
            
            completion(currentForecast,nil)
        }
    }
    
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
