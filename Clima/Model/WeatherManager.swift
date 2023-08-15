//
//  WeatherManager.swift
//  Clima
//
//  Created by shih-feng on 2023/8/14.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager{

    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=0fc70a34c94166385a34d786a285ded6&units=metric"
    
    func fetchWeather(_ cityName:String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString)
    }
    
    func performRequest(_ urlSting:String){
        if let url = URL(string:urlSting){
            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url) { (data, response, error) in
//                if error != nil {
//                    print(error!)
//                    return
//                }
//                if let safeData = data {
//                    let dataString = String(data:safeData, encoding: .utf8)
//                    print(dataString!)
//                }
//            }
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                                if error != nil {
                                    print(error!)
                                    return
                                }
                                if let safeData = data {
                                    if let weather = self.parseJSON(weatherData: safeData) {
                                        let weatherVC = WeatherViewController()
                                        weatherVC.didUpdateWeather(weather)
                                    }
                                }
                            })
            task.resume()
        }
        
    }
    func parseJSON(weatherData: Data) -> WeatherModal? {
        let decoder = JSONDecoder()
        do{
          let decodedData =  try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            
            //Use the data above to make an object.
            let weather = WeatherModal(conditionId: id, CityName: name, temperature: temp)
            
           return weather
            
           
        } catch {
            print(error)
            return nil
        }
       
    }
    

    
}
