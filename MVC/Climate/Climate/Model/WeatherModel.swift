//
//  WeatherModel.swift
//  Climate
//
//  Created by 김태호 on 2023/07/31.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let tempMax: Double
    let tempMin: Double
    
    var temperatureToString: String {
        return String(format: "%.1f°", temperature)
    }
    
    var tempMaxToString: String {
        return String(format: "%.0f°", tempMax)
    }
    
    var tempMinToString: String {
        return String(format: "%.0f°", tempMin)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200..<300:
            return "cloud.bolt"
        case 300..<400:
            return "cloud.drizzle"
        case 500..<600:
            return "cloud.rain"
        case 600..<700:
            return "cloud.snow"
        case 700...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
