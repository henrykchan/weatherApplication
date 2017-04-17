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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        createLayout()
        
    }

    func createLayout() {
        
        self.view.backgroundColor = UIColor.blue
        
        self.view.addSubview(currentTempLabel)
//        currentTempLabel.backgroundColor = UIColor.white
        currentTempLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(self.view.snp.top).offset(100)
            make.width.equalTo(self.view.snp.width)
//            make.height.equalTo(self.view.snp.height).dividedBy(4)
        }
        currentTempLabel.text = "66°"
        currentTempLabel.font = UIFont(name: "Avenir-Light", size: 100)
        currentTempLabel.textColor = UIColor.black
//        currentTempLabel.baselineAdjustment = .alignCenters
        currentTempLabel.textAlignment = .center
    }
  

}

