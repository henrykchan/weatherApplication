//
//  FiveDayForecastCell.swift
//  weatherApplication
//
//  Created by Henry Chan on 4/22/17.
//  Copyright © 2017 Henry Chan. All rights reserved.
//

import UIKit

class FiveDayForecastCell: UICollectionViewCell {
    

    var weatherIDImageView = UIImageView()
    var highTempLabel = UILabel()
    var lowTempLabel = UILabel()
    var dayOfWeekLabel = UILabel()
//    let blackOverLay = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        contentView.addSubview(dayOfWeekLabel)
        dayOfWeekLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(contentView.snp.top)
            make.width.equalTo(contentView.snp.width)
        }
        dayOfWeekLabel.text = "Mon"
        dayOfWeekLabel.textColor = .white
        dayOfWeekLabel.textAlignment = .center
        dayOfWeekLabel.adjustsFontSizeToFitWidth = true
        dayOfWeekLabel.minimumScaleFactor = 0.3
        
        contentView.addSubview(weatherIDImageView)
        weatherIDImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(dayOfWeekLabel.snp.bottom).offset(20)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        weatherIDImageView.tintColor = .white
        
        contentView.addSubview(highTempLabel)
        highTempLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(weatherIDImageView.snp.bottom).offset(40)
            make.width.equalTo(contentView.snp.width)
        }
        highTempLabel.textColor = .white
        highTempLabel.textAlignment = .center
        highTempLabel.adjustsFontSizeToFitWidth = true
        highTempLabel.minimumScaleFactor = 0.3
        
        
        contentView.addSubview(lowTempLabel)
        lowTempLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(highTempLabel.snp.bottom)
            make.width.equalTo(contentView.snp.width)
        }

        lowTempLabel.textColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        lowTempLabel.textAlignment = .center
        lowTempLabel.adjustsFontSizeToFitWidth = true
        lowTempLabel.minimumScaleFactor = 0.3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("ello")
    }
}
