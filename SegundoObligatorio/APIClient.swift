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
import SwiftDate

class APIClient {
    
    static let sharedClient = APIClient()
    private let baseURL = "http://api.openweathermap.org/data/2.5/forecast/daily?"
    private let lat = ""
    private let lon = ""
    private let mode = "json"
    private let ctn = "7"
    private var units = "metric"
    private let APIKEY = "bda63d1506b53aeba67a39e883876d21"
    
    private init() {
        
    }

    
    func wheatherOnCompletion(latitude : Double, longitude:Double,units:Int, OnCompletion: (WeatherList : WeatherList?, error: NSError?)  -> Void){
        if(units == 0){
            self.units = "metric"
        }else{
            self.units="imperial"
        }
        
        let request_url = "\(self.baseURL)lat=\(latitude)&lon=\(longitude)&units=\(self.units)&ctn=\(self.ctn)&appid=\(self.APIKEY)"
            
        Alamofire.request(.GET, request_url).validate().responseJSON{ response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    
                    let weatherListObj = WeatherList()
                    var weatherListArray = [Weather]()
                    let dateFormatter = NSDateFormatter()
                    let json = JSON(value)
                    print("\(json)")
                    weatherListObj.city = json["city"]["name"].stringValue
                    
                    for weather in json["list"].arrayValue {
                        let weatherObj = Weather()
                        
                        let day = NSDate(timeIntervalSince1970: weather["dt"].doubleValue)
                        dateFormatter.dateFormat = "EEE"
                        let stringDay = dateFormatter.stringFromDate(day)
                        
                        let minTemp = weather["temp"] ["min"].doubleValue
                        let maxTemp = weather["temp"] ["max"].doubleValue
                        let icon = weather["weather"][0]["icon"].stringValue
                        let condition = weather["weather"][0]["id"].intValue
                        
                        weatherObj.day = stringDay
                        weatherObj.minTemp = minTemp
                        weatherObj.maxTemp = maxTemp
                        weatherObj.icon = icon
                        weatherObj.condition = condition
                        
                        weatherListArray.append(weatherObj)
                    }
                    
                    weatherListObj.weathers = weatherListArray;
                    
                    OnCompletion(WeatherList: weatherListObj, error: nil)
                }
            case .Failure(let error):
                print(error)
                OnCompletion(WeatherList:nil, error: NSError(domain: "GET DATA", code: 999, userInfo: [NSLocalizedDescriptionKey : "Fallo al obtener los datos"]))
            }
        }
        
        
    }
    
    
}