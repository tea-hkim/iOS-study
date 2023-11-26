//
//  Todo.swift
//  BasicTodoList
//
//  Created by 김태호 on 11/26/23.
//

import Foundation

struct Todo: Hashable {
    let id = UUID()
    let title: String
    let creationDate: Date
    var isDone: Bool
}
