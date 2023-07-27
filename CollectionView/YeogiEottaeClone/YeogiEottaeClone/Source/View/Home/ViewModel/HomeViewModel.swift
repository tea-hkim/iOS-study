//
//  HomeViewModel.swift
//  YeogiEottaeClone
//
//  Created by Nick on 2023/07/27.
//

import Foundation

final class HomeViewModel {
    
    // Data
    
    var moduleList: [Module]? {
        didSet {
            onCompleted()
        }
    }
    
    // Input
    
    // Output
    
    var onCompleted: () -> Void = {}
    
    
    // MARK: - Functions
        
    internal func dataTask() {
        let urlString = "http://192.168.0.107:3000/home"
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
                guard let self else { return }
                if let error = error {
                    return print("⚠️URL Error", error.localizedDescription)
                }
                
                if let jsonData = data {
                    do {
                        let someData = try JSONDecoder().decode(Entity.self, from: jsonData)
                        self.moduleList = someData.data.modules
                    } catch {
                        return print("⚠️JSON Decoding Error ", error.localizedDescription)
                    }
                }
            }.resume()
        }
    }
    
}
