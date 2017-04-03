//
//  NetworkRequest.swift
//  weatherApplication
//
//  Created by Henry Chan on 4/2/17.
//  Copyright © 2017 Henry Chan. All rights reserved.
//

import Foundation
import Alamofire

//Requesting Network
struct NetworkRequest {
    
    static func urlRequest (url: String, method: HTTPMethod, parameters: Parameters?, completionHandler: @escaping (DataResponse<Any>) -> Void) {
        
        Alamofire.request(url, method: method, parameters: parameters).validate().responseJSON(completionHandler: completionHandler)
    }
}
