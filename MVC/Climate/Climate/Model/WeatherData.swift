//
//  WeatherData.swift
//  Climate
//
//  Created by 김태호 on 2023/07/31.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let tempMax: Double
    let tempMin: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMax = "temp_max"
        case tempMin = "temp_min"
    }
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
}
