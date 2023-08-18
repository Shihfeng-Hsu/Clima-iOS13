//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//https://api.openweathermap.org/data/2.5/weather?q=Taipei&appid=0fc70a34c94166385a34d786a285ded6&units=metric

import UIKit
import CoreLocation

//Beacuse the software keyboard can't set in a IBOutlet
//so we need to use the UITextFieldDelegate to catch the events happen by the software keyboard.
class WeatherViewController: UIViewController  {


    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

        searchTextField.delegate = self
        weatherManager.delegate = self
        }
    
    
    @IBAction func relocationButton(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

//MARK: - CLLocationManagerDelegate
extension WeatherViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
//            weatherManager.fetchWeather(nil, latitude:lat, longitude:lon)
//        }
            weatherManager.fetchWeather( latitude:lat, longitude:lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}


//MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    
    //for software keyboard.
    //Trigger by delegates.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        } else {
            textField.placeholder = "type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text{
//            weatherManager.fetchWeather(city,latitude: nil,longitude: nil)
            weatherManager.fetchWeather(city)
        }
        
        searchTextField.text = ""
    }
    
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController : WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager,_ weather: WeatherModal?) {
        if let weatherData =  weather{
            DispatchQueue.main.async {
                print(weatherData.conditionName)
                self.temperatureLabel.text =  weatherData.temperatureString
                self.conditionImageView.image = UIImage(systemName: weatherData.conditionName)
                self.cityLabel.text = weatherData.CityName
            }
        }
    }
    
    func didFailWithError(error:Error){
        print(error)
    }
    
    
}

