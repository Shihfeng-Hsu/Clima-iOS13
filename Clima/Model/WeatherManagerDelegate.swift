//
//  WeatherManagerDelegate.swift
//  Clima
//
//  Created by shih-feng on 2023/8/15.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager,_ weather: WeatherModal?)
    func didFailWithError(error:Error)
}
