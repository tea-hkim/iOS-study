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
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoCell.identifier, for: indexPath)
        cell.backgroundColor = .white
        return cell
    }

}

