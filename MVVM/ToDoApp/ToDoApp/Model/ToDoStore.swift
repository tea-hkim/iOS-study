//
//  ToDoStore.swift
//  ToDoApp
//
//  Created by 김태호 on 2023/04/14.
//

import Combine
import Foundation

class ToDoStore {
    static let shared = ToDoStore()
    
    @Published var todoItems = [ToDoModel]()
}
