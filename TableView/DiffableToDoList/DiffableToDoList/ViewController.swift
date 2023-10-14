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
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "할일 목록"
    }

    // MARK: TableView Datasource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : todoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.section != 0 else {
            let cell = UITableViewCell()
            cell.backgroundColor = .black
            cell.textLabel?.textColor = .white
            cell.textLabel?.text = "할일 추가하기"
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoCell.identifier, for: indexPath) as? TodoCell
        else { return UITableViewCell() }
        cell.configure(with: todoList[indexPath.row])
        return cell
    }
    
    // MARK: TableView Delegate
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section != 0 else { return nil }
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = .lightGray
        let label = UILabel()
        label.frame = CGRect.init(x: 10, y: 0, width: headerView.frame.width-10, height: headerView.frame.height)
        label.text = "남은 할일"
        label.font = .systemFont(ofSize: 24)
        headerView.addSubview(label)
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 50
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = TodoDetailViewController()
        
        if indexPath.section != 0  {
            detailVC.configure(with: todoList[indexPath.row])
        }
        navigationController?.pushViewController(detailVC, animated: true)
    }
    

}

