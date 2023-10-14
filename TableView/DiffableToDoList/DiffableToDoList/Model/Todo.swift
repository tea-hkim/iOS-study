//
//  Todo.swift
//  DiffableToDoList
//
//  Created by 김태호 on 10/12/23.
//

import UIKit

struct Todo: Hashable {
    let title: String
    var isDone: Bool
    
    static let mockTodoList: [Todo] = [
        Todo(title: "청소하기", isDone: false),
        Todo(title: "책읽기", isDone: true),
        Todo(title: "빨래하기", isDone: false),
        Todo(title: "피아노 연습", isDone: true),
        Todo(title: "농구 드리블 연습", isDone: false),
        Todo(title: "클린 아키텍처 읽기", isDone: true),
        Todo(title: "클린 코드 읽기", isDone: false),
        Todo(title: "설거지하기", isDone: false),
        Todo(title: "분리수거", isDone: false),
    ]
}
