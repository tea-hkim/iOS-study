//
//  ToDoViewModel.swift
//  ToDoApp
//
//  Created by 김태호 on 2023/04/11.
//

import Combine
import Foundation

final class ToDoViewModel {
    
    //MARK: - Properties
    
    var todoData: ToDoModel?
    
    private let todoAPI = ToDoAPI()
    private var cancelBag = Set<AnyCancellable>()
    
    //MARK: - Lifecycle
    
    init(todoData: ToDoModel? = nil) {
        self.todoData = todoData
    }
    
    //MARK: - API Functions
    
    func addTodo(title: String, isDone: Bool) {
        todoAPI.postToDo(title: title, isDone: isDone)
            .sink { error in
                switch error {
                case .failure(let error):
                    print(error.localizedErrorString)
                case.finished: break
                }
            } receiveValue: { todo in
                ToDoStore.shared.todoItems.insert(todo, at: 0)
            }.store(in: &cancelBag)
    }
    
    func editTodo(title: String, isDone: Bool) {
        guard let todoID = todoData?.id else { return }
        todoAPI.editToDo(id: todoID, title: title, isDone: isDone)
            .sink { error in
                switch error {
                case .failure(let error):
                    print(error.localizedErrorString)
                case.finished: break
                }
            } receiveValue: { todo in
                ToDoStore.shared.todoItems = ToDoStore.shared.todoItems.map { $0.id == todo.id ? todo : $0 }
            }.store(in: &cancelBag)
    }

}
