//
//  ViewController.swift
//  weatherApplication
//
//  Created by Henry Chan on 3/30/17.
//  Copyright © 2017 Henry Chan. All rights reserved.
//

import UIKit
import SnapKit

class WeatherController: UIViewController {
    
    var forecast:Forecast!
    var currentTempLabel = UILabel()
    var highTempLabel = UILabel()
    var lowTempLabel = UILabel()
    var conditionLabel = UILabel()
    var cityNameLabel = UILabel()
    var windSpeedLabel = UILabel()
    var backgroundImage = UIImageView()
    let dividerLineLabel = UILabel()
    let sharedInstance = DataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        createLayout()
        gettingWeather()
        
    }

    func createLayout() {
        
        self.view.backgroundColor = UIColor.white
        
        // CurrentTemp Label constraints and settings
        self.view.addSubview(currentTempLabel)
        currentTempLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(self.view.snp.top).offset(100)
        }
//        currentTempLabel.text = "66°"
        currentTempLabel.font = UIFont(name: "Avenir-Light", size: 100)
        currentTempLabel.textColor = UIColor.black
//        currentTempLabel.baselineAdjustment = .alignCenters
        currentTempLabel.textAlignment = .center
        currentTempLabel.backgroundColor = UIColor.blue
        currentTempLabel.adjustsFontSizeToFitWidth = true
        currentTempLabel.numberOfLines = 0
        currentTempLabel.lineBreakMode = .byWordWrapping
        
        // Condition Label constraints and settings
        currentTempLabel.addSubview(conditionLabel)
        conditionLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(currentTempLabel.snp.centerX)
            make.top.equalTo(currentTempLabel.snp.centerY).offset(40)
        }
        conditionLabel.text = "Breezy"
        conditionLabel.textColor = UIColor.black
        conditionLabel.textAlignment = .center
        conditionLabel.adjustsFontSizeToFitWidth = true
        conditionLabel.numberOfLines = 0
        
        // High Temp Label constraints and settings
        self.view.addSubview(highTempLabel)
        highTempLabel.snp.makeConstraints { (make) in
            make.left.equalTo(currentTempLabel.snp.left)
            make.top.equalTo(currentTempLabel.snp.bottom).offset(2)
        }
        highTempLabel.text = "72 High"
        highTempLabel.textColor = UIColor.black
        highTempLabel.textAlignment = .center
        highTempLabel.adjustsFontSizeToFitWidth = true
        highTempLabel.numberOfLines = 0
        
        // Low Temp Label constraints and settings
        self.view.addSubview(lowTempLabel)
        lowTempLabel.snp.makeConstraints { (make) in
            make.left.equalTo(highTempLabel.snp.right).offset(25)
            make.top.equalTo(currentTempLabel.snp.bottom).offset(2)
        }
        lowTempLabel.text = "40 Low"
        lowTempLabel.textColor = UIColor.black
        lowTempLabel.textAlignment = .center
        lowTempLabel.adjustsFontSizeToFitWidth = true
        lowTempLabel.numberOfLines = 0
        
        // Wind Speed Label constraints and settings
        self.view.addSubview(windSpeedLabel)
        windSpeedLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(highTempLabel.snp.bottom).offset(20)
        }
        windSpeedLabel.text = "5 m/s Wind"
        windSpeedLabel.textColor = UIColor.black
        windSpeedLabel.textAlignment = .center
        windSpeedLabel.adjustsFontSizeToFitWidth = true
        windSpeedLabel.numberOfLines = 0
        
        // Divider Label constraints and settings
        self.view.addSubview(dividerLineLabel)
        dividerLineLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(windSpeedLabel.snp.bottom).offset(100)
            make.width.equalTo(self.view.snp.width)
            make.height.equalTo(1)
        }
        dividerLineLabel.backgroundColor = UIColor.black
    }
    
    func gettingWeather() {
        sharedInstance.getWeather(city: "brooklyn") { (forecast, error) in
            
            guard let unwrappedForecast = forecast else{return}
            
            if let error = error {
                print ("Oops looks like there is an error fetching forecast, Error:\(error)")
            }
            else {
                self.currentTempLabel.text = String(describing: unwrappedForecast.currentTemp)
            }
        }
    }

}

