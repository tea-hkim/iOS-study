//
//  ViewController.swift
//  DiffableToDoList
//
//  Created by 김태호 on 10/11/23.
//

import UIKit

class ViewController: UITableViewController {

    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .white
        tableView.register(TodoCell.self, forCellReuseIdentifier: TodoCell.identifier)
    }

    // MARK: TableView Datasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoCell.identifier, for: indexPath) as? TodoCell
        else { return UITableViewCell() }
        cell.configure(with: Todo(title: "할일 목록 \(indexPath.row)", image: nil))
        return cell
    }

}

