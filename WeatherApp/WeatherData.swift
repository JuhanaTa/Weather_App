//
//  WeatherData.swift
//  WeatherApp
//
//  Created by iosdev on 13.11.2020.
//  Copyright © 2020 iosdev. All rights reserved.
//

import Foundation

class WeatherData: WeatherObservable {
    
    var observers = [WeatherObserver]()
    
    func registerObserver(observer: WeatherObserver) {
        if observers.firstIndex(where:{($0 as AnyObject) === (observer as AnyObject)}) == nil {
            observers.append(observer as AnyObject as! WeatherObserver)
        }
    }
    
    func deRegisterObserver(observer: WeatherObserver) {
        if let index = observers.firstIndex(where:{($0 as AnyObject) === (observer as AnyObject)}) {
            observers.remove(at: index)
        }
    }
    
    
    
    func getWeatherData(city: String) {
    
    guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid={APIKEY}") else {
        fatalError("failed to create URL")
    }
    
    let task = URLSession.shared.dataTask(with: url) {data, response, error in
        if let error = error {
            print("Client error \(error)")
        }
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            return
        }
        
        guard let data2 = data else {
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let weather = try decoder.decode(WeatherFeed.self, from: data2)
            print(weather.main.temp)
     
            //looppaa observerit ja kutsu update
            for observer in self.observers {
                observer.update(main: weather.main, wind: weather.wind, desc: weather.weather)
            }
            
            
        } catch let err {
            print("Err", err)
        }
                    
    }
    task.resume()
        
    }
    
    
}
