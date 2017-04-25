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

class WeatherController: UIViewController, CLLocationManagerDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var forecast:Forecast!
    var forecasts = [Forecast]()
    var currentTempLabel = UILabel()
    var highTempLabel = UILabel()
    var lowTempLabel = UILabel()
    var conditionLabel = UILabel()
    var cityNameLabel = UILabel()
    var windSpeedLabel = UILabel()
    var backgroundImageView = UIImageView()
    var weatherIDImageView = UIImageView()
    let dividerLineLabel = UILabel()
    let sharedInstance = DataStore.sharedInstance
    let locationManager = CLLocationManager()
    var latitude = Double()
    var longitude = Double()
    var cityName = String()
    var fiveDayForecastView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        
        setUpFiveDayForecastCell()
        setupLocationManager()
        createLayout()
        gettingFiveDayWeather()
        gettingCityNameBasedOnCoordinates()
        
        
       
        
        
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
            make.top.equalTo(currentTempLabel.snp.centerY).offset(50)
        }
        conditionLabel.textColor = UIColor.white
        conditionLabel.textAlignment = .center
        conditionLabel.adjustsFontSizeToFitWidth = true
        conditionLabel.numberOfLines = 0
        
        // High Temp Label constraints and settings
        backgroundImageView.addSubview(highTempLabel)
        highTempLabel.snp.makeConstraints { (make) in
            make.left.equalTo(currentTempLabel.snp.left)
            make.centerY.equalTo(self.view.snp.centerY).offset(-60)
//            make.centerX.equalTo(self.view.snp.centerX)
        }
        highTempLabel.textColor = UIColor.white
        highTempLabel.textAlignment = .center
        highTempLabel.adjustsFontSizeToFitWidth = true
        highTempLabel.numberOfLines = 0
        
        // Low Temp Label constraints and settings
        backgroundImageView.addSubview(lowTempLabel)
        lowTempLabel.snp.makeConstraints { (make) in
            make.left.equalTo(highTempLabel.snp.right).offset(25)
            make.centerY.equalTo(self.view.snp.centerY).offset(-60)
//            make.centerX.equalTo(self.view.snp.centerX)
        }
        lowTempLabel.textColor = UIColor.white
        lowTempLabel.textAlignment = .center
        lowTempLabel.adjustsFontSizeToFitWidth = true
        lowTempLabel.numberOfLines = 0
        
        // Wind Speed Label constraints and settings
        backgroundImageView.addSubview(windSpeedLabel)
        windSpeedLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(self.view.snp.centerY).offset(-20)
        }
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
        
        // weatherID imageview constraints and settings
        backgroundImageView.addSubview(weatherIDImageView)
        weatherIDImageView.snp.makeConstraints { (make) in
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.left.equalTo(currentTempLabel.snp.right).offset(5)
            make.centerY.equalTo(currentTempLabel.snp.centerY)
        }
        weatherIDImageView.tintColor = .white
//        weatherIDImageView.image = weatherIDImageView.image?.withRenderingMode(.alwaysTemplate)
        
        // Setup FiveDayForecast Collection View
        backgroundImageView.addSubview(fiveDayForecastView)
        fiveDayForecastView.snp.makeConstraints { (make) in
            make.top.equalTo(dividerLineLabel.snp.bottom)
            make.width.equalTo(backgroundImageView.snp.width)
            make.bottom.equalTo(backgroundImageView.snp.bottom)
            make.left.equalTo(backgroundImageView.snp.left)
        }
        fiveDayForecastView.backgroundColor = .clear
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
//        print(forecasts.count)
        return forecasts.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        gettingFiveDayWeather()
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "forecastCell", for: indexPath) as! FiveDayForecastCell
        cell.backgroundColor = .blue
        
        for (index, eachForecast) in forecasts.enumerated() {
            
            if index > 0 {
                cell.highTempLabel.text = String(eachForecast.highTemp)
                cell.lowTempLabel.text = String(eachForecast.lowTemp)
            }
        }
        
//        print(cell.highTempLabel.text as Any)
        return cell
    }
    
    func setUpFiveDayForecastCell() {
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width / 5
        let screenHeight = screenSize.height / 3
        
        //setup Layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        layout.itemSize = CGSize(width: screenWidth, height: screenHeight)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 0
        fiveDayForecastView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        fiveDayForecastView.dataSource = self
        fiveDayForecastView.delegate = self
        
        fiveDayForecastView.register(FiveDayForecastCell.self, forCellWithReuseIdentifier: "forecastCell")
        fiveDayForecastView.isUserInteractionEnabled = true
    }
    
    
    func gettingFiveDayWeather () {
        
        sharedInstance.getFiveDayWeather(latitude: String(self.latitude), longitude: String(self.longitude)) { (theForecasts, error) in
            
            if let error = error {
                print ("Oops looks like there is an error fetching forecasts, Error:\(error)")
            }
                
            else {
                
                guard let unwrappedForecasts = theForecasts else{return}
                
                self.forecasts = unwrappedForecasts
                
                let firstForecast = self.forecasts[0]
                
                self.currentTempLabel.text = String(describing: firstForecast.currentTemp) + "°"
                self.conditionLabel.text = (firstForecast.condition).capitalized
                self.highTempLabel.text = "High: " + String(describing: firstForecast.highTemp)
                self.lowTempLabel.text = "Low: " + String(describing: firstForecast.lowTemp)
                self.windSpeedLabel.text = String(describing: firstForecast.windSpeed) + " m/s"
                self.weatherIDImageView.image = self.weatherImage(forecast: firstForecast).withRenderingMode(.alwaysTemplate)
                
                self.fiveDayForecastView.reloadData()

            }
        }
        
    }
    
    // Fuction for CLLocationManager delegates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    // Fuction for CLLocationManager delegates
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
            print("Oops unable to fetch coordinates, Error:\(error)")
    
    }
    
    // CLLocation Manager settings and setting coordinates
    func setupLocationManager() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.requestLocation()
        
        if let unwrappedLocation = locationManager.location {
            self.latitude = unwrappedLocation.coordinate.latitude
            self.longitude = unwrappedLocation.coordinate.longitude
        }
    }
    
    // Function to return different images based on condition
    func weatherImage(forecast: Forecast) -> UIImage {
        
        switch forecast.weatherID {
        
        case 200...232, 901,902,961,962 :
            return #imageLiteral(resourceName: "thunderStorm")
        case 300...321:
            return #imageLiteral(resourceName: "lightRain")
        case 500...531:
            return #imageLiteral(resourceName: "rain")
        case 600...622:
            return #imageLiteral(resourceName: "snow")
        case 800,904:
            return #imageLiteral(resourceName: "sunny")
        case 801...804,951:
            return #imageLiteral(resourceName: "clearDay")
        case 781,900:
            return #imageLiteral(resourceName: "tornado")
        case 905,952...959:
            return #imageLiteral(resourceName: "windy")
        case 906:
            return #imageLiteral(resourceName: "hail")
        default:
            return #imageLiteral(resourceName: "question")
        }
    }
    
    func gettingCityNameBasedOnCoordinates() {
        
        let location = CLLocation(latitude: self.latitude, longitude: self.longitude)
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            
            if error != nil {
                print("Reverse geocoder failed with error, Error:\(String(describing: error?.localizedDescription))")
            }
            
            guard let unwrappedPlacemarks = placemarks else {return}
            
            if unwrappedPlacemarks.count > 0 {
                let placemark = unwrappedPlacemarks[0]
                
                //Setting city name label text from place mark locality using coordinates
                self.cityNameLabel.text = placemark.locality
            }
            
            else {
                print("Problem with the data received from geocoder")
            }
        }
    }
    

}


//        print(self.forecasts)
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



