//
//  WeatherModal.swift
//  Clima
//
//  Created by shih-feng on 2023/8/15.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModal {
    let conditionId:Int
    let CityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f",temperature)
    }
    
    var conditionName: String {
        switch conditionId {
                case 200...232:
                    return "cloud.bolt"
                case 300...321:
                    return "cloud.drizzle"
                case 500...531:
                    return "cloud.rain"
                case 600...622:
                    return "cloud.snow"
                case 701...781:
                    return "cloud.fog"
                case 800:
                    return "sun.max"
                case 801...804:
                    return "cloud"
                default:
                    return "cloud"
                }
    }
    
//    func getConditionName(conditionID: Int) -> String {
//        switch conditionID {
//                case 200...232:
//                    return "cloud.bolt"
//                case 300...321:
//                    return "cloud.drizzle"
//                case 500...531:
//                    return "cloud.rain"
//                case 600...622:
//                    return "cloud.snow"
//                case 701...781:
//                    return "cloud.fog"
//                case 800:
//                    return "sun.max"
//                case 801...804:
//                    return "cloud.bolt"
//                default:
//                    return "cloud"
//                }
//
//    }
    
}
