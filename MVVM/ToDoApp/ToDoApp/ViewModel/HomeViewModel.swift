//
//  HomeViewModel.swift
//  ToDoApp
//
//  Created by 김태호 on 2023/04/10.
//

import Combine
import Foundation

final class HomeViewModel {
    
    //MARK: - Properties
    
    private let todoAPI = ToDoAPI()
    private var cancelBag = Set<AnyCancellable>()
    
    private var todoList: [ToDoModel] = [] {
        didSet {
            todoSectionList = makeSections(with: self.todoList)
        }
    }
    
    var isHideCompleted: Bool = false
    
    //Input
    @Published var searchTerm: String = ""
    
    //Output
    @Published var todoSectionList = [ToDoSection]()
    
    var currentPage: Int = 1
    private var isLoading: Bool = false
    
    //MARK: - Lifecycle
    
    init() {
        fetchToDoList()
        bind()
    }
    
    //MARK: - Bind Combine
    
    func bind() {
        ToDoStore.shared.$todoItems
            .assign(to: \.todoList, on: self)
            .store(in: &cancelBag)
    }
    
    //MARK: - API Functions
    
    func refreshToDoList() {
        currentPage = 1
        fetchToDoList(page: currentPage)
    }
    
    func prefetchToDoList() {
        if isLoading {
            return
        } else {
            if searchTerm.isEmpty {
                currentPage += 1
                fetchToDoList(page: currentPage)
            } else {
                currentPage += 1
                searchToDoList(with: searchTerm, page: currentPage)
            }
        }
    }
    
    func fetchToDoList(page: Int = 1) {
        isLoading = true
        todoAPI.fetchToDoList(page: page)
            .sink { error in
                switch error {
                case .failure(let error):
                    print(error.localizedErrorString)
                case.finished: break
                }
            } receiveValue: { todoList in
                if self.currentPage == 1 {
                    ToDoStore.shared.todoItems = todoList
                } else {
                    ToDoStore.shared.todoItems.append(contentsOf: todoList)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.isLoading = false
                })
            }.store(in: &cancelBag)
    }
    
    func searchToDoList(with term: String, page: Int = 1) {
        isLoading = true
        todoAPI.searchToDoList(by: searchTerm, page: page)
            .sink { error in
                switch error {
                case .failure(let error):
                    print(error.localizedErrorString)
                case.finished: break
                }
            } receiveValue: { todoList in
                if self.currentPage == 1 {
                    ToDoStore.shared.todoItems = todoList
                } else {
                    ToDoStore.shared.todoItems.append(contentsOf: todoList)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.isLoading = false
                })
            }.store(in: &cancelBag)
    }
    
    func deleteTodo(id: Int) {
        todoAPI.deleteToDo(id: id)
            .sink { error in
                switch error {
                case .failure(let error):
                    print(error.localizedErrorString)
                case.finished: break
                }
            } receiveValue: { todo in
                if let todoID = todo.id {
                    ToDoStore.shared.todoItems = ToDoStore.shared.todoItems.filter { $0.id != todoID }
                }
            }.store(in: &cancelBag)
    }
    
    func hideComplete() {
        isHideCompleted.toggle()
        
        if isHideCompleted {
            todoList = todoList.filter { $0.isDone == false }
        } else {
            todoList = ToDoStore.shared.todoItems
        }
    }
    
    func todoCompleted(_ todo: ToDoModel) {
        guard let id = todo.id,
              let title = todo.title,
              let isDone = todo.isDone else { return }
        todoAPI.editToDo(id: id, title: title, isDone: !isDone)
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
    
    private func makeSections(with todoList: [ToDoModel]) -> [ToDoSection] {
        var groupedData = [String: [ToDoModel]]()
        var sectionList = [ToDoSection]()
        
        for todo in todoList {
            guard let dateString = todo.createdAt else { return [] }
            let date = dateString[...dateString.index(dateString.startIndex, offsetBy: 9)]
                        .replacingOccurrences(of: "-", with: ".")
            if groupedData[date] == nil {
                groupedData[date] = [todo]
            } else {
                groupedData[date]?.append(todo)
            }
        }
        
        let sortedKeys = groupedData.keys.sorted(by: >)
        
        for key in sortedKeys {
            let section = ToDoSection(dateTitle: String(key), todos: groupedData[key] ?? [ToDoModel]())
            sectionList.append(section)
        }
        return sectionList
    }
    
}
