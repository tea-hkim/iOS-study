//
//  TodoCell.swift
//  DiffableToDoList
//
//  Created by 김태호 on 10/12/23.
//

import UIKit

class TodoCell: UITableViewCell {
    
    // MARK:  Properties
    
    static let identifier: String = "TodoCell"
    private var todo: Todo?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    
    // MARK: Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        createLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - TodoCell Method
    
    public func configure(with todo: Todo) {
        self.todo = todo
        configureAttribute()
    }
    
}

// MARK: - UI Function

extension TodoCell {
    
    private func configureAttribute() {
        backgroundColor = .white
        titleLabel.text = todo?.title
    }
    
    private func createLayout() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
