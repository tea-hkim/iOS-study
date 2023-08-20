//
//  ToDo.swift
//  ToDoApp
//
//  Created by Nick on 2023/04/09.
//

import Foundation

struct ToDoModel: Codable {
    let id: Int?
    let title: String?
    let isDone: Bool?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case isDone = "is_done"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    func getTimeToString() -> String? {
        guard let dateString = self.createdAt else { return nil }
        let startIndex = dateString.index(dateString.startIndex, offsetBy: 11)
        let endIndex = dateString.index(startIndex, offsetBy: 4)
        let timeString = String(dateString[startIndex...endIndex])
        return timeString
    }
}
