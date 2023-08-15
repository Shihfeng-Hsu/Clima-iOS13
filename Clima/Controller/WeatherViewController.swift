//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//https://api.openweathermap.org/data/2.5/weather?q=Taipei&appid=0fc70a34c94166385a34d786a285ded6&units=metric

import UIKit
//Beacuse the software keyboard can't set in a IBOutlet
//so we need to use the UITextFieldDelegate to catch the events happen by the software keyboard.
class WeatherViewController: UIViewController, UITextFieldDelegate {
    
    let weatherManager = WeatherManager()

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        }
    
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
            weatherManager.fetchWeather(city)
        }
        
        searchTextField.text = ""
    }
    
    func didUpdateWeather(_ weather:WeatherModal){
        print(weather)
        
    }
    
    

}

