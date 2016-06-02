//
//  Models.swift
//  SegundoObligatorio
//
//  Created by Rodrigo Suarez Balbi on 6/1/16.
//  Copyright © 2016 Universidad Catolica. All rights reserved.
//

import Foundation


class Weather: NSObject {
    
    var day: String?
    var condition: Int?
    var minTemp: Double?
    var maxTemp: Double?
    var icon: String?
    
}


class WeatherList: NSObject{
    
    var city: String?
    var weathers: [Weather]?
    
}