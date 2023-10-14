//
//  TodoDetailViewController.swift
//  DiffableToDoList
//
//  Created by 김태호 on 10/14/23.
//

import UIKit

class TodoDetailViewController: UIViewController {
    
    // MARK: Property
    
    private var todo: Todo?
    
    private enum Layout {
        enum Padding {
            static let leading : CGFloat = 20
            static let trailing: CGFloat = -20
            static let top: CGFloat = 20
        }
        
        enum Size {
            static let textFieldHeight: CGFloat = 50
            static let imageSize: CGFloat = 100
        }
    }
    
    // MARK: UI Property
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 32)
        return label
    }()
    
    private let todoTextField: UITextField = {
        let textField = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: Layout.Size.textFieldHeight))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 20
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 2
        return textField
    }()
    
    private let todoImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let addImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 20
        button.setTitle("이미지 추가하기", for: .normal)
        return button
    }()
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createLayout()
    }
    
    // MARK: Public function
    
    internal func configure(with todo: Todo) {
        self.todo = todo
    }

}

// MARK: - UI Fucitons

extension TodoDetailViewController {
    
    private func configureUI () {
        view.backgroundColor = .white
        
        guard let todo else {
            titleLabel.text = "할일 입력"
            todoImage.image = UIImage(systemName: "photo")
            return
        }
        
        titleLabel.text = "할일 수정"
        todoTextField.text = todo.title
        todoImage.image = UIImage(systemName: "person")
    }
    
    private func createLayout() {
        [titleLabel, todoTextField, todoImage, addImageButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Layout.Padding.top),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.Padding.leading),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Layout.Padding.trailing),
            
            todoTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Layout.Padding.top),
            todoTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            todoTextField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            todoTextField.heightAnchor.constraint(equalToConstant: Layout.Size.textFieldHeight),
            
            todoImage.topAnchor.constraint(equalTo: todoTextField.bottomAnchor, constant: Layout.Padding.top),
            todoImage.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            todoImage.heightAnchor.constraint(equalToConstant: Layout.Size.imageSize),
            todoImage.widthAnchor.constraint(equalToConstant: Layout.Size.imageSize),
            
            addImageButton.topAnchor.constraint(equalTo: todoImage.bottomAnchor, constant: Layout.Padding.top),
            addImageButton.leadingAnchor.constraint(equalTo: todoImage.leadingAnchor),
            addImageButton.trailingAnchor.constraint(equalTo: todoImage.trailingAnchor),
            addImageButton.heightAnchor.constraint(equalToConstant: Layout.Size.textFieldHeight)
        ])
    }
        
}


