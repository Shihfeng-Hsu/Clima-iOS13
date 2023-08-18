//
//  WeatherManager.swift
//  Clima
//
//  Created by shih-feng on 2023/8/14.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherManager{

    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=0fc70a34c94166385a34d786a285ded6&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    
//    func fetchWeather(_ cityName:String?,latitude:CLLocationDegrees?, longitude:CLLocationDegrees?){
//        if let cityName = cityName{
//            let urlString = "\(weatherURL)&q=\(cityName)"
//            performRequest(with: urlString)
//        }else if let latitude = latitude, let longitude = longitude{
//            let urlString = "\(weatherURL)&lat=\(String(describing: latitude))&lon=\(String(describing: longitude))"
//            performRequest(with: urlString)
//        }
//    }
//    
    //surprise! Swift can accept multiple function in same name!
        func fetchWeather(_ cityName:String){
                let urlString = "\(weatherURL)&q=\(cityName)"
                performRequest(with: urlString)
            }
            func fetchWeather(latitude:CLLocationDegrees, longitude:CLLocationDegrees){
                    let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
                    performRequest(with: urlString)
                }
    
    //Use "with" as the parameter name to make parameter more readable.
    func performRequest(with urlSting:String){
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
                                    self.delegate?.didFailWithError(error: error!)
                                    return
                                }
                                if let safeData = data {
                                    if let weather = self.parseJSON(weatherData: safeData) {
                                        //Not reuseable//
//                                        let weatherVC = WeatherViewController()
//                                        weatherVC.didUpdateWeather(weather)
                                        
                                        //reuseable// ---> with delegate
                                        //self keyword infront of .delegate is needed, because if we have many delegates, when calling the delegates without self keyword would come acorss errors.
                                        //pass self into the function, will bring the whole struct into the delegate.
                                        self.delegate?.didUpdateWeather( self, weather)
                                        
                                    }
                                }
                            })
            task.resume()
        }
        
    }
    func parseJSON(weatherData: Data) -> WeatherModal? {
        let decoder = JSONDecoder()
        do{
            //func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
            //The WeatherData is a struct e.g a concept, So when we use it to be a Realized items, the ".self" is needed.
            let decodedData =  try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            
            //Use the data above to make an object.
            let weather = WeatherModal(conditionId: id, CityName: name, temperature: temp)
            
           return weather
            
           
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
       
    }
    

    
}
