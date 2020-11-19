//
//  ViewController.swift
//  WeatherApp
//
//  Created by iosdev on 13.11.2020.
//  Copyright © 2020 iosdev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, WeatherObserver {

    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    var weatherData = WeatherData()
    
    var cities = ["Helsinki", "Porvoo", "Turku", "Espoo", "Vantaa", "Rovaniemi", "Oulu", "Imatra", "Kajaani", "Vaasa", "Kotka", "Utsjoki"]
    var city = ""
    
    
    func update(main: MainInfo, wind: [String:Double], desc: [Weather]) {
        DispatchQueue.main.async {
            print(main)
            print(wind["speed"] ?? 0.0)
            for one in desc {
                print(one.description)
                self.descLabel.text = "desc: \(one.description)"
            }
            self.tempLabel.text = "temp: \(((main.temp - 273.15) * 10).rounded() / 10) C"
            self.minTempLabel.text = "min temp: \(((main.temp_min - 273.15) * 10).rounded() / 10) C"
            self.maxTempLabel.text = "max temp: \(((main.temp_max - 273.15) * 10).rounded() / 10) C"
            self.windLabel.text = "wind: \(wind["speed"] ?? 0.0) m/s"
            self.cityLabel.text = self.city
            
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        city = "Helsinki"
        weatherData.registerObserver(observer: self)
        // Do any additional setup after loading the view.
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 12
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "\(cities[row])"
        }
        else {
            return "\(cities[row])"
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow: Int, inComponent: Int) {
        if (inComponent == 0) {
            print("\(didSelectRow)")
            print("city is \(cities[didSelectRow])")
            city = cities[didSelectRow]
        }
    }
    
    @IBAction func searchAction(_ sender: UIButton) {
        weatherData.getWeatherData(city: city)
    }


}

