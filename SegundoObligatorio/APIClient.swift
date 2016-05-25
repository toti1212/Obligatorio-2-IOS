//
//  APIClient.swift
//  SegundoObligatorio
//
//  Created by Rodrigo Suarez Balbi on 5/25/16.
//  Copyright © 2016 Universidad Catolica. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIClient {
    static let sharedClient = APIClient()
    private let baseURL = "http://api.openweathermap.org/data/2.5/forecast/daily?"
    private let location = "London"
    private let mode = "json"
    private let units = "metric"
    private let ctn = "7"
    private let APIKEY = "bda63d1506b53aeba67a39e883876d21"
    private init() {
        
    }
    
    func wheatherOnCompletion(OnCompletion: ()  -> Void){
        let request_url = self.baseURL +
            "q=" + self.location +
            "&mode=" + self.mode +
            "&units=" + self.units +
            "&ctn=" + self.ctn +
            "&appid=" + self.APIKEY
        
        Alamofire.request(.GET, request_url).validate().responseJSON{ (response:Response<AnyObject, NSError>) -> Void in
            print (response)
            }
        
        
    }
    
    
}