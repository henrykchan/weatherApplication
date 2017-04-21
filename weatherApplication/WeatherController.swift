//
//  ViewController.swift
//  weatherApplication
//
//  Created by Henry Chan on 3/30/17.
//  Copyright © 2017 Henry Chan. All rights reserved.
//

import UIKit
import SnapKit
import CoreLocation

class WeatherController: UIViewController, CLLocationManagerDelegate {
    
    var forecast:Forecast!
    var currentTempLabel = UILabel()
    var highTempLabel = UILabel()
    var lowTempLabel = UILabel()
    var conditionLabel = UILabel()
    var cityNameLabel = UILabel()
    var windSpeedLabel = UILabel()
    var backgroundImageView = UIImageView()
    let dividerLineLabel = UILabel()
    let sharedInstance = DataStore.sharedInstance
    let locationManager = CLLocationManager()
    var latitude = Double()
    var longitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        setupLocationManager()
        createLayout()
        gettingWeather()
        
        
    }

    func createLayout() {
        
        self.view.backgroundColor = UIColor.white
        
        // backgroundImage constraints and settings
        self.view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top)
            make.bottom.equalTo(self.view.snp.bottom)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
        }
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.image = #imageLiteral(resourceName: "nightBG")
        
        // City Name Label constraints and settings
        backgroundImageView.addSubview(cityNameLabel)
        cityNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(50)
            make.centerX.equalTo(self.view.snp.centerX)
        }
        
        cityNameLabel.textColor = UIColor.white
        cityNameLabel.textAlignment = .center
        cityNameLabel.adjustsFontSizeToFitWidth = true
        cityNameLabel.numberOfLines = 0
        
        
        // CurrentTemp Label constraints and settings
        backgroundImageView.addSubview(currentTempLabel)
        currentTempLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(self.view.snp.top).offset(100)
        }
//        currentTempLabel.text = "66°"
        currentTempLabel.font = UIFont(name: "Avenir-Light", size: 100)
        currentTempLabel.textColor = UIColor.white
//        currentTempLabel.baselineAdjustment = .alignCenters
        currentTempLabel.textAlignment = .center
//        currentTempLabel.backgroundColor = UIColor.blue
        currentTempLabel.adjustsFontSizeToFitWidth = true
        currentTempLabel.numberOfLines = 0
        currentTempLabel.lineBreakMode = .byWordWrapping
        
        // Condition Label constraints and settings
        currentTempLabel.addSubview(conditionLabel)
        conditionLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(currentTempLabel.snp.centerX)
            make.top.equalTo(currentTempLabel.snp.centerY).offset(40)
        }
//        conditionLabel.text = "Breezy"
        conditionLabel.textColor = UIColor.white
        conditionLabel.textAlignment = .center
        conditionLabel.adjustsFontSizeToFitWidth = true
        conditionLabel.numberOfLines = 0
        
        // High Temp Label constraints and settings
        backgroundImageView.addSubview(highTempLabel)
        highTempLabel.snp.makeConstraints { (make) in
            make.left.equalTo(currentTempLabel.snp.left)
            make.centerY.equalTo(self.view.snp.centerY).offset(-100)
        }
//        highTempLabel.text = "72 High"
        highTempLabel.textColor = UIColor.white
        highTempLabel.textAlignment = .center
        highTempLabel.adjustsFontSizeToFitWidth = true
        highTempLabel.numberOfLines = 0
        
        // Low Temp Label constraints and settings
        backgroundImageView.addSubview(lowTempLabel)
        lowTempLabel.snp.makeConstraints { (make) in
            make.left.equalTo(highTempLabel.snp.right).offset(25)
            make.centerY.equalTo(self.view.snp.centerY).offset(-100)
        }
//        lowTempLabel.text = "40 Low"
        lowTempLabel.textColor = UIColor.white
        lowTempLabel.textAlignment = .center
        lowTempLabel.adjustsFontSizeToFitWidth = true
        lowTempLabel.numberOfLines = 0
        
        // Wind Speed Label constraints and settings
        backgroundImageView.addSubview(windSpeedLabel)
        windSpeedLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(self.view.snp.centerY).offset(-50)
        }
//        windSpeedLabel.text = "5 m/s Wind"
        windSpeedLabel.textColor = UIColor.white
        windSpeedLabel.textAlignment = .center
        windSpeedLabel.adjustsFontSizeToFitWidth = true
        windSpeedLabel.numberOfLines = 0
        
        // Divider Label constraints and settings
        backgroundImageView.addSubview(dividerLineLabel)
        dividerLineLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(self.view.snp.centerY).offset(30)
            make.width.equalTo(self.view.snp.width)
            make.height.equalTo(1)
        }
        dividerLineLabel.backgroundColor = UIColor.white
    }
    
    func gettingWeather() {
        
        sharedInstance.getWeather(latitude: String(self.latitude), longitude: String(self.longitude)) { (forecast, error) in
            
            guard let unwrappedForecast = forecast else{return}
            
            if let error = error {
                print ("Oops looks like there is an error fetching forecast, Error:\(error)")
            }
            else {
                self.currentTempLabel.text = String(describing: unwrappedForecast.currentTemp) + "°"
                self.conditionLabel.text = (unwrappedForecast.condition).capitalized
                self.cityNameLabel.text = (unwrappedForecast.cityName).capitalized
                self.highTempLabel.text = "High: " + String(describing: unwrappedForecast.highTemp)
                self.lowTempLabel.text = "Low: " + String(describing: unwrappedForecast.lowTemp)
                self.windSpeedLabel.text = String(describing: unwrappedForecast.windSpeed) + " m/s"
            }
        }
//        sharedInstance.getWeather(city: "brooklyn") { (forecast, error) in
//
//            guard let unwrappedForecast = forecast else{return}
//            
//            if let error = error {
//                print ("Oops looks like there is an error fetching forecast, Error:\(error)")
//            }
//            else {
//                self.currentTempLabel.text = String(describing: unwrappedForecast.currentTemp) + "°"
//                self.conditionLabel.text = (unwrappedForecast.condition).capitalized
//                self.cityNameLabel.text = (unwrappedForecast.cityName).capitalized
//                self.highTempLabel.text = "High: " + String(describing: unwrappedForecast.highTemp)
//                self.lowTempLabel.text = "Low: " + String(describing: unwrappedForecast.lowTemp)
//                self.windSpeedLabel.text = String(describing: unwrappedForecast.windSpeed) + " m/s"
//            }
//        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
            print("Oops unable to fetch coordinates, Error:\(error)")
    
    }
    
    func setupLocationManager() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.requestLocation()
        self.latitude =  (locationManager.location?.coordinate.latitude)!
        self.longitude = (locationManager.location?.coordinate.longitude)!
    }
    

}



