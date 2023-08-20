//
//  NetworkError.swift
//  ToDoApp
//
//  Created by 김태호 on 2023/04/10.
//

import Foundation

public enum NetworkError: Error {
    case invalidUrl
    case badResponse
    case decodingError
    case badRequest(String)
    case serverError
    case noContent
    case unknown(String)
    
    public var localizedErrorString: String {
        switch self {
        case .invalidUrl:
            return "🚨invalid url🚨"
        case .badResponse:
            return "🚨bad response🚨"
        case .decodingError:
            return "🚨decoding error🚨"
        case .badRequest(let responseBody):
            return "🚨status code: 400🚨: 잘못된 문법입니다 \(responseBody)"
        case .serverError:
            return "🚨status code: 5XX🚨: 서버가 명백히 유효한 요청에 대한 충족을 실패했습니다"
        case .noContent:
            return "🚨빈 데이터입니다🚨"
        case .unknown(let unknownError):
            return "🚨unknown🚨: 알 수 없는 에러\(unknownError)"
        }
    }
    
}
