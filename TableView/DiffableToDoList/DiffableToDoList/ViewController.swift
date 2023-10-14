//
//  ViewController.swift
//  DiffableToDoList
//
//  Created by 김태호 on 10/11/23.
//

import UIKit

final class ViewController: UITableViewController {
    
    // MARK: - Property
    
    private let todoList: [Todo] = Todo.mockTodoList
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .white
        tableView.register(TodoCell.self, forCellReuseIdentifier: TodoCell.identifier)
    }

    // MARK: TableView Datasource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 5 }
        else { return todoList.count}
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.section != 0 else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "wow"
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoCell.identifier, for: indexPath) as? TodoCell
        else { return UITableViewCell() }
        cell.configure(with: todoList[indexPath.row])
        return cell
    }
    
    // MARK: TableView Delegate
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 { return "첫번째 섹션" }
        else { return "그냥 섹션"}
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = TodoDetailViewController()
        detailVC.configure(with: todoList[indexPath.row])
        navigationController?.pushViewController(detailVC, animated: true)
    }
    

}

