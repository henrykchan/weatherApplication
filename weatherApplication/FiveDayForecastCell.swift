//
//  FiveDayForecastCell.swift
//  weatherApplication
//
//  Created by Henry Chan on 4/22/17.
//  Copyright © 2017 Henry Chan. All rights reserved.
//

import UIKit

class FiveDayForecastCell: UICollectionViewCell, UICollectionViewDelegate {
    
    var forecast: Forecast?
    var weatherIDImageView = UIImageView()
    var highTempLabel = UILabel()
    var lowTempLabel = UILabel()
    var dayOfWeekLabel = UILabel()
//    let blackOverLay = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        contentView.addSubview(blackOverLay)
//        blackOverLay.snp.makeConstraints { (make) in
//            make.bottom.equalTo(contentView.snp.bottom)
//            make.top.equalTo(contentView.snp.top)
//            make.left.equalTo(contentView.snp.left)
//            make.height.equalTo(contentView.snp.right)
//        }
        contentView.addSubview(dayOfWeekLabel)
        dayOfWeekLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(contentView.snp.top).offset(2)
            make.width.equalTo(contentView.snp.width)
        }
        dayOfWeekLabel.text = "Mon"
        
        contentView.addSubview(weatherIDImageView)
        contentView.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(dayOfWeekLabel.snp.bottom).offset(2)
            make.width.equalTo(10)
            make.height.equalTo(10)
        }
        weatherIDImageView.backgroundColor = .green
        
        contentView.addSubview(highTempLabel)
        highTempLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(weatherIDImageView.snp.bottom).offset(2)
            make.width.equalTo(contentView.snp.width)
        }
        highTempLabel.text = "70"
        highTempLabel.textColor = .white
        
        
        contentView.addSubview(lowTempLabel)
        lowTempLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(highTempLabel.snp.bottom).offset(2)
            make.width.equalTo(contentView.snp.width)
        }
        lowTempLabel.text = "70"
        lowTempLabel.textColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
