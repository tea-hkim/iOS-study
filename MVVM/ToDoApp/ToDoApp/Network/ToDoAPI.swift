//
//  ToDoAPI.swift
//  ToDoApp
//
//  Created by Nick on 2023/04/10.
//

import Combine
import Foundation

final class ToDoAPI {
    
    //MARK: - Networking Methods
    
    func fetchToDoList(page: Int = 1) -> AnyPublisher<[ToDoModel], NetworkError> {
        let urlString = API.baseURL + "/todos?" + "page=\(page)&order_by=desc&per_page=10"
        
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap({ (data: Data, response: URLResponse) in
                if let error = self.checkError(data: data, response: response) {
                    throw error
                }
                return data
            })
            .decode(type: ToDoWrapper.self, decoder: JSONDecoder())
            .compactMap( \.data )
            .mapError({ error in
                if let error = error as? NetworkError {
                    return error
                }
                return NetworkError.decodingError
            })
            .eraseToAnyPublisher()
    }
    
    func searchToDoList(by term: String, page: Int = 1) -> AnyPublisher<[ToDoModel], NetworkError> {
        guard var urlComponent = URLComponents(string: API.baseURL + "/todos/search") else {
            return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
        }
        urlComponent.queryItems = ["query" : term,
                                   "order_by": "desc",
                                   "page" : "\(page)",
                                   "per_page": "10"].map { URLQueryItem(name: $0.key, value: $0.value)}
        
        guard let url = urlComponent.url else {
            return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap({ (data: Data, response: URLResponse) in
                if let error = self.checkError(data: data, response: response) {
                    throw error
                }
                return data
            })
            .decode(type: ToDoWrapper.self, decoder: JSONDecoder())
            .compactMap( \.data )
            .mapError({ error in
                if let error = error as? NetworkError {
                    return error
                }
                return NetworkError.decodingError
            })
            .eraseToAnyPublisher()
    }
    
    func postToDo(title: String, isDone: Bool) -> AnyPublisher<ToDoModel, NetworkError> {
        let urlString = API.baseURL + "/todos"
        
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestParams : [String : Any] = ["title": title, "is_done" : "\(isDone)"]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestParams, options: [.prettyPrinted])
            urlRequest.httpBody = jsonData
        } catch {
            return Fail(error: NetworkError.unknown("encoding error")).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap({ (data: Data, response: URLResponse) in
                if let error = self.checkError(data: data, response: response) {
                    throw error
                }
                return data
            })
            .decode(type: TodoReponse.self, decoder: JSONDecoder())
            .compactMap(\.data)
            .mapError ({ error in
                if let error = error as? NetworkError {
                    return error
                }
                return NetworkError.unknown("unknown error")
            })
            .eraseToAnyPublisher()
    }
    
    func editToDo(id: Int, title: String, isDone: Bool = false) -> AnyPublisher<ToDoModel, NetworkError> {
        let urlString = API.baseURL + "/todos-json/\(id)"
        
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestParams : [String : Any] = ["title": title, "is_done" : "\(isDone)"]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestParams, options: [.prettyPrinted])
            urlRequest.httpBody = jsonData
        } catch {
            return Fail(error: NetworkError.unknown("encoding error")).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap({ (data: Data, response: URLResponse) in
                if let error = self.checkError(data: data, response: response) {
                    throw error
                }
                return data
            })
            .decode(type: TodoReponse.self, decoder: JSONDecoder())
            .compactMap(\.data)
            .mapError ({ error in
                if let error = error as? NetworkError {
                    return error
                }
                return NetworkError.unknown("unknown error")
            })
            .eraseToAnyPublisher()
    }
    
    func deleteToDo(id: Int) -> AnyPublisher<ToDoModel, NetworkError> {
        let urlString = API.baseURL + "/todos/\(id)"
        
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        urlRequest.addValue("application/json", forHTTPHeaderField: "accept")
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap({ (data: Data, response: URLResponse) in
                if let error = self.checkError(data: data, response: response) {
                    throw error
                }
                return data
            })
            .decode(type: TodoReponse.self, decoder: JSONDecoder())
            .compactMap(\.data)
            .mapError ({ error in
                if let error = error as? NetworkError {
                    return error
                }
                return NetworkError.decodingError
            })
            .eraseToAnyPublisher()
    }
    
    private func checkError(data: Data, response: URLResponse) -> NetworkError? {
        guard let httpResponse = response as? HTTPURLResponse else {
            return NetworkError.badResponse
        }
        if let responseBody = String(data: data, encoding: String.Encoding.utf8) {
            switch httpResponse.statusCode {
            case 200..<300: return nil
            case 400..<500: return .badRequest(responseBody)
            case 500...: return .serverError
            default: return .unknown("\(httpResponse.statusCode)")
            }
        }
        return .unknown("data encoding 실패")
    }
    
}
