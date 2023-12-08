//
//  TodoList.swift
//  DiffableToDoList
//
//  Created by 김태호 on 10/15/23.
//

import Foundation

class TodoList {
    
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
    
    // MARK: CRUD
    
    static var todoList: [Todo] = mockTodoList
    
    static func addNew(todo: Todo) {
        todoList.insert(todo, at: 0)
    }
    
    static func update(todo: Todo) {
        guard let todoIndex = todoList.firstIndex(where: { todo.id == $0.id }) else { 
            return print("업데이트하려는 할일이 없습니다")
        }
        todoList[todoIndex] = todo
    }
    
    static func delete(todo: Todo) {
        guard let todoIndex = todoList.firstIndex(where: { todo.id == $0.id }) else { 
            return print("삭제하려는 할일이 없습니다")
        }
        todoList.remove(at: todoIndex)
    }
}
