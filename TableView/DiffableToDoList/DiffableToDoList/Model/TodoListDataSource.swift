//
//  TodoListDataSource.swift
//  DiffableToDoList
//
//  Created by 김태호 on 10/14/23.
//

import UIKit

enum Section {
    case Done
    case Todo
}

class TodoListDataSource: UITableViewDiffableDataSource<Section, Todo> {

}
