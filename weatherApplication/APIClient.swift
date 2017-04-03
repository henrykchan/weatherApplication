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
    
    static func getForecast(latitude: String, longitude: String, completion: @escaping ([String: Any]) -> Void) {
        
        let urlString =  "\(Secret.apiUrl)\(Secret.apiUrl)/\(latitude),\(longitude)"
        
    }
    
}
