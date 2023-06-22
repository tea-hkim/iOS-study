//
//  Network.swift
//  MovieApp
//
//  Created by 김태호 on 2023/06/21.
//

import Foundation

import RxSwift
import RxAlamofire

class Network<T: Decodable> {
    private let endpoint: String
    private let queue: ConcurrentDispatchQueueScheduler
    
    init(endpoint: String) {
        self.endpoint = endpoint
        self.queue = ConcurrentDispatchQueueScheduler(qos: .background)
    }
    
    func getIemList(path: String) -> Observable<T> {
        let fullPath = "\(endpoint)\(path)?api_key=\(API.key)&language=\(Language.korean)"
        return RxAlamofire.data(.get, fullPath)
            .observe(on: queue)
            .debug()
            .map { data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            }
    }
}
