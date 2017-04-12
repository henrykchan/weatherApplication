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
        
        let urlString =  "\(Secret.apiUrl)\(Secret.apiUrl)/\(latitude),\(longitude)"
        
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
