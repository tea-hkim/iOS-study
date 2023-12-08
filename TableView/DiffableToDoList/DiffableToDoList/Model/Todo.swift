//
//  Todo.swift
//  DiffableToDoList
//
//  Created by 김태호 on 10/12/23.
//

import UIKit

struct Todo: Hashable {
    let id = UUID()
    let title: String
    var isDone: Bool
}
