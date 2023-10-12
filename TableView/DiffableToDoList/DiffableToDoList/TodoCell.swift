//
//  TodoCell.swift
//  DiffableToDoList
//
//  Created by 김태호 on 10/12/23.
//

import UIKit

class TodoCell: UITableViewCell {
    
    static let identifier: String = "TodoCell"
    
    // MARK:  Properties
    
    private let todoLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
