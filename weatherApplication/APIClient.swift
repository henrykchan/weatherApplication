//
//  APIClient.swift
//  weatherApplication
//
//  Created by Henry Chan on 4/2/17.
//  Copyright © 2017 Henry Chan. All rights reserved.
//

import Foundation
import Alamofire

struct APIClient {
    
    static func getForecast(latitude: String, longitude: String, completion: @escaping ([String: Any]?, NSError?) -> Void) {
        
        let urlString =  "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&APPID=\(Secret.apiKey)"
        
        NetworkRequest.urlRequest(url: urlString, method: .get, parameters: nil) { (dataResponse) in
            
            guard let JSON = dataResponse.result.value
                else {
                    completion(nil, dataResponse.result.error as NSError?)
                    return
            }
            
            completion(JSON as? [String:Any] , nil)
        }
        
    }
    
}


//http://api.openweathermap.org/data/2.5/weather?lat=40.641078&lon=74.012268&APPID=76e80501f278a7d7c4b99b05eed3f228
