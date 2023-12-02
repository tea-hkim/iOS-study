//
//  TodoCell.swift
//  BasicTodoList
//
//  Created by 김태호 on 11/26/23.
//

import UIKit

final class TodoCell: UITableViewCell {
    
    static let identifier = "TodoCell"
    
    // MARK: - Properties
    
    private var todo: Todo?
    
    private let todoLabel = UILabel()
    private let createdDateLabel = UILabel()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        createLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        
    }
    
    // MARK: - Public Method
    
    public func configure(with todo: Todo) {
        self.todo = todo
        configureUI()
    }
    
}

// MARK: - UI Functions

extension TodoCell {
    
    private func configureUI() {
        backgroundColor = .white
        
        todoLabel.text = todo?.title
        todoLabel.textColor = .black
        todoLabel.numberOfLines = 0
        
        createdDateLabel.text = todo?.creationDate.toString()
        createdDateLabel.font = .systemFont(ofSize: 10)
        createdDateLabel.textColor = .lightGray
        createdDateLabel.numberOfLines = 1
    }
    
    private func createLayout() {
        [todoLabel, createdDateLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            todoLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            todoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            todoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            createdDateLabel.topAnchor.constraint(equalTo: todoLabel.bottomAnchor, constant: 5),
            createdDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            createdDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            createdDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    
}
