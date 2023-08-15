//
//  WeatherData.swift
//  Clima
//
//  Created by shih-feng on 2023/8/14.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation


//Data for Decoder
//Decodable is a protocol, there is a "Encodable" protoco for the data that need to be encoded to JSON or other types of data.
//If some data need to be both to encoded or decoded, use "Codable" potocol
struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather : [Weather] //just for pointing out the data. Because the weather property is a array.
}

struct Main: Decodable {
    let temp : Double
}

struct Weather:  Decodable  {
    let id : Int
    let description : String
}
