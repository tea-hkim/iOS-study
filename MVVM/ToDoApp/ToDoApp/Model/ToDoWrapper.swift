//
//  ToDoDTO.swift
//  ToDoApp
//
//  Created by Nick on 2023/04/10.
//

import Foundation

//MARK: - Fetch TodoList

struct ToDoWrapper: Codable {
    let data: [ToDoModel]?
    let meta: Meta?
    let message: String?
}

struct Meta: Codable {
    let currentPage, from, lastPage, perPage: Int?
    let to, total: Int?

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case from
        case lastPage = "last_page"
        case perPage = "per_page"
        case to, total
    }
}

//MARK: - Response Todo

struct TodoReponse: Codable {
    let data: ToDoModel?
    let message: String?
}
