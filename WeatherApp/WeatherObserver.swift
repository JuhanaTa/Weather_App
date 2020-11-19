//
//  WeatherObserver.swift
//  WeatherApp
//
//  Created by iosdev on 19.11.2020.
//  Copyright © 2020 iosdev. All rights reserved.
//

import Foundation

protocol WeatherObserver {
    func update(main: MainInfo,wind: [String:Double], desc: [Weather])
}
