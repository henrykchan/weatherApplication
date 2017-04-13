//
//  DataStore.swift
//  weatherApplication
//
//  Created by Henry Chan on 4/12/17.
//  Copyright © 2017 Henry Chan. All rights reserved.
//

import Foundation


struct DataStore {
    
    static let sharedInstance = DataStore()
    fileprivate init() {}
    
    
    func getWeather(completion: @escaping )
}
