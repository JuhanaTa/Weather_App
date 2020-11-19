//
//  WeatherFeed.swift
//  WeatherApp
//
//  Created by iosdev on 13.11.2020.
//  Copyright © 2020 iosdev. All rights reserved.
//

import Foundation

struct WeatherFeed:Codable {
    var coord: [String:Double]
    var weather: [Weather]
    var base:String
    var main:MainInfo
    var visibility:Int
    var wind:[String:Double]
    var clouds:[String:Int]
    var dt:Int
    var sys:Sys
    var id: Int
    var name:String?
    
    private enum CodingKeys:String, CodingKey {
        case coord
        case weather = "weather"
        case base
        case main
        case visibility
        case wind
        case clouds
        case dt
        case sys
        case id
        case name
    }
    
};

struct Weather:Codable {
    var id:Int?
    var main:String
    var description:String
    var icon:String
}

struct MainInfo:Codable {
    var temp:Double
    var pressure:Int
    var humidity:Int
    var temp_min:Double
    var temp_max:Double
}

struct Sys:Codable {
    var type:Int
    var id:Int
    var message:Double?
    var country:String
    var sunrise:Int
    var sunset:Int
}


