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

class WeatherController: UIViewController, CLLocationManagerDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    var forecast:Forecast!
    var forecasts = [Forecast]()
    var currentTempLabel = UILabel()
    var highTempLabel = UILabel()
    var lowTempLabel = UILabel()
    var conditionLabel = UILabel()
    var cityNameLabel = UILabel()
    var windSpeedLabel = UILabel()
    var windImageView = UIImageView()
    var currentDayLabel = UILabel()
    var backgroundImageView = UIImageView()
    var weatherIDImageView = UIImageView()
    let firstDividerLineLabel = UILabel()
    let secondDividerLineLabel = UILabel()
    let scrollViewForecast = UIScrollView()
    let sharedInstance = DataStore.sharedInstance
    let locationManager = CLLocationManager()
    var latitude = Double()
    var longitude = Double()
    var cityName = String()
    var fiveDayForecastView: UICollectionView!
    var currentDayOfTheWeek = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        setUpFiveDayForecastCell()
        createLayout()
        setupLocationManager()
        gettingFiveDayWeather()
        gettingCityNameBasedOnCoordinates()
        
        
        
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
            make.top.equalTo(self.view.snp.top).offset(70)
            make.centerX.equalTo(self.view.snp.centerX)
        }
        
        cityNameLabel.textColor = UIColor.white
        cityNameLabel.textAlignment = .center
        cityNameLabel.adjustsFontSizeToFitWidth = true
        cityNameLabel.numberOfLines = 0
        cityNameLabel.font = cityNameLabel.font.withSize(30)
        cityNameLabel.minimumScaleFactor = 0.3
        
        
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
        currentTempLabel.adjustsFontSizeToFitWidth = true
        currentTempLabel.minimumScaleFactor = 0.3
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
        conditionLabel.minimumScaleFactor = 0.3
        
        // High Temp Label constraints and settings
        backgroundImageView.addSubview(highTempLabel)
        highTempLabel.snp.makeConstraints { (make) in
            make.left.equalTo(currentTempLabel.snp.left)
            make.centerY.equalTo(self.view.snp.centerY).offset(-40)
//            make.centerX.equalTo(self.view.snp.centerX)
        }
        highTempLabel.textColor = UIColor.white
        highTempLabel.textAlignment = .center
        highTempLabel.adjustsFontSizeToFitWidth = true
        highTempLabel.numberOfLines = 0
        highTempLabel.minimumScaleFactor = 0.3
        
        // Low Temp Label constraints and settings
        backgroundImageView.addSubview(lowTempLabel)
        lowTempLabel.snp.makeConstraints { (make) in
            make.left.equalTo(highTempLabel.snp.right).offset(25)
            make.centerY.equalTo(self.view.snp.centerY).offset(-40)
//            make.centerX.equalTo(self.view.snp.centerX)
        }
        lowTempLabel.textColor = UIColor.white
        lowTempLabel.textAlignment = .center
        lowTempLabel.adjustsFontSizeToFitWidth = true
        lowTempLabel.numberOfLines = 0
        lowTempLabel.minimumScaleFactor = 0.3
        
        // Wind Speed Label constraints and settings
        backgroundImageView.addSubview(windSpeedLabel)
        windSpeedLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(self.view.snp.centerY).offset(-10)
        }
        windSpeedLabel.textColor = UIColor.white
        windSpeedLabel.textAlignment = .center
        windSpeedLabel.adjustsFontSizeToFitWidth = true
        windSpeedLabel.numberOfLines = 0
        windSpeedLabel.minimumScaleFactor = 0.3
        
        // Wind image constraints and settings
        backgroundImageView.addSubview(windImageView)
        windImageView.snp.makeConstraints { (make) in
            make.left.equalTo(windSpeedLabel.snp.right).offset(5)
            make.width.equalTo(25)
            make.height.equalTo(25)
            make.centerY.equalTo(windSpeedLabel.snp.centerY)
        }
        windImageView.image = #imageLiteral(resourceName: "wind").withRenderingMode(.alwaysTemplate)
        windImageView.tintColor = .white
        
        // weatherID imageview constraints and settings
        backgroundImageView.addSubview(weatherIDImageView)
        weatherIDImageView.snp.makeConstraints { (make) in
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.left.equalTo(currentTempLabel.snp.right).offset(5)
            make.centerY.equalTo(currentTempLabel.snp.centerY)
        }
        weatherIDImageView.tintColor = .white
        
        
        // Setup FiveDayForecast Collection View
        backgroundImageView.addSubview(fiveDayForecastView)
        fiveDayForecastView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.centerY).offset(90)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottom)
            make.left.equalTo(self.view.snp.left)
        }
        fiveDayForecastView.backgroundColor = .clear

        
        //Divider Label constraints and settings
        
        //First Divider
        backgroundImageView.addSubview(firstDividerLineLabel)
        firstDividerLineLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.bottom.equalTo(fiveDayForecastView.snp.top)
            make.width.equalTo(self.view.snp.width)
            make.height.equalTo(1)
        }
        firstDividerLineLabel.backgroundColor = UIColor.white
        
        //Second Divider
        backgroundImageView.addSubview(secondDividerLineLabel)
        secondDividerLineLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.bottom.equalTo(firstDividerLineLabel.snp.top).offset(-10)
            make.width.equalTo(self.view.snp.width)
            make.height.equalTo(1)
        }
        secondDividerLineLabel.backgroundColor = UIColor.white
        
        // Current day label constraints and settings
        backgroundImageView.addSubview(currentDayLabel)
        currentDayLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(secondDividerLineLabel.snp.top)
            make.width.equalTo(self.view.snp.width)
            make.left.equalTo(self.view.snp.left).offset(10)
        }
        currentDayLabel.textColor = .white
        currentDayLabel.text = getCurrentDay() + "  Today"
        currentDayLabel.adjustsFontSizeToFitWidth = true
        currentDayLabel.numberOfLines = 0
        currentDayLabel.minimumScaleFactor = 0.3
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("This is the count \(forecasts.count)")

        return forecasts.count - 1
      
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "forecastCell", for: indexPath) as? FiveDayForecastCell
        
        var newForecast = self.forecasts
        newForecast.remove(at: 0)
        
        cell?.highTempLabel.text = String(newForecast[indexPath.row].highTemp)
        cell?.lowTempLabel.text = String(newForecast[indexPath.row].lowTemp)
        cell?.weatherIDImageView.image = self.weatherImage(forecast: newForecast[indexPath.row]).withRenderingMode(.alwaysTemplate)
        cell?.dayOfWeekLabel.text = self.getRestOfTheWeek()[indexPath.row]
        
        return cell!
    }
    
    func setUpFiveDayForecastCell() {
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width / 5
        let screenHeight = screenSize.height / 3.5
        
        //setup Layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: screenWidth, height: screenHeight)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 0
        fiveDayForecastView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        fiveDayForecastView.dataSource = self
        fiveDayForecastView.delegate = self
        
        fiveDayForecastView.register(FiveDayForecastCell.self, forCellWithReuseIdentifier: "forecastCell")
        fiveDayForecastView.isScrollEnabled = true
        fiveDayForecastView.alwaysBounceHorizontal = true
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
                DispatchQueue.main.async {
                    self.currentTempLabel.text = String(describing: firstForecast.currentTemp) + "°"
                    self.conditionLabel.text = (firstForecast.condition).capitalized
                    self.highTempLabel.text = "High: " + String(describing: firstForecast.highTemp)
                    self.lowTempLabel.text = "Low: " + String(describing: firstForecast.lowTemp)
                    self.windSpeedLabel.text = String(describing: firstForecast.windSpeed) + " m/s"
                    self.weatherIDImageView.image = self.weatherImage(forecast: firstForecast).withRenderingMode(.alwaysTemplate)
                    
                    self.fiveDayForecastView.reloadData()
//                    print("\(self.fiveDayForecastView.numberOfItems(inSection: 0))")
                    dump(self.forecasts)
                }
                
                
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
    
    func getDayOfWeek()->Int {
        
        let todayDate = NSDate()
        let myCalendar = NSCalendar(calendarIdentifier: .gregorian)
        
        guard let unrappedCalandar = myCalendar else{return 1}
        
        let myComponents = unrappedCalandar.components(.weekday, from: todayDate as Date)
        let weekDay = myComponents.weekday
        
        guard let unwrappedWeekDay = weekDay else {return 1}
        
        
        
        return unwrappedWeekDay
    }
    
    func getCurrentDay() -> String {
        
        switch getDayOfWeek() {
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        default:
            return "Sunday"
        }
    }
    
    func getRestOfTheWeek() -> [String] {
        
        switch getDayOfWeek() {
        case 1:
            return ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        case 2:
            return ["Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        case 3:
            return ["Wed", "Thu", "Fri", "Sat", "Sun", "Mon"]
        case 4:
            return ["Thu", "Fri", "Sat", "Sun", "Mon", "Tues"]
        case 5:
            return ["Fri", "Sat", "Sun", "Mon", "Tue", "Wed"]
        case 6:
            return ["Sat", "Sun", "Mon", "Tue", "Wed", "Thu"]
        default:
            return ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri"]
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




