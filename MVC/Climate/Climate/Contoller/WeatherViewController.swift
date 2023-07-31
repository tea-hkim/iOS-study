//
//  ViewController.swift
//  Climate
//
//  Created by 김태호 on 2023/07/29.
//

import UIKit

final class WeatherViewController: UIViewController {

    // MARK: - UI Components
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWeather(with: "seoul")
    }


}

// MARK: - Networking

extension WeatherViewController {
    
    private func fetchWeather(with cityName: String) {
        let urlString = "\(API.weatherURL)&lang=\(Language.korean)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    private func fetchWeather(lat: Double, lon: Double) {
        let urlString = "\(API.weatherURL)&lang=\(Language.korean)&lat=\(lat)&lon=\(lon)"
        performRequest(with: urlString)
    }
    
    private func performRequest(with urlString: String) {
        if let url = URL(string: urlString)  {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil { return print(error?.localizedDescription ?? "에러 메세지") }
                
                if let safeData = data {
                    guard let weather = self.parseJSON(safeData) else { return }
                    DispatchQueue.main.async {
                        self.temperatureLabel.text = weather.temperatureToString
                        self.cityNameLabel.text = weather.cityName
                        self.maxTempLabel.text = weather.tempMaxToString
                        self.minTempLabel.text = weather.tempMinToString
                    }
                }
            }
            task.resume()
        }
    }
    
    private func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp,
                                       tempMax: decodedData.main.tempMax, tempMin: decodedData.main.tempMin)
            
            return weather
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    
}
