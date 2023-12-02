//
//  MainViewController.swift
//  BasicTodoList
//
//  Created by 김태호 on 11/26/23.
//

import UIKit

final class MainViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        tableView.register(TodoCell.self, forCellReuseIdentifier: TodoCell.identifier)
    }
        
    
    // MARK: DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TodoList.empty.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoCell.identifier, for: indexPath) as? TodoCell else {
            return UITableViewCell()
        }
        let todo = TodoList.empty[indexPath.row]
        cell.configure(with: todo)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

// MARK: - UI Functions

extension MainViewController {
    
    private func configureUI() {
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        
        navigationItem.title = "할일 목록"
    }
    
    
}
