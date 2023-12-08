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
            static let top: CGFloat = 15
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
    
    private let todoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    private let todoLabel: UILabel = {
        let label = UILabel()
        label.text = "할일"
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private let todoTextField: UITextField = {
        let textField = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: Layout.Size.textFieldHeight))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 2
        return textField
    }()
    
    private let completionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    private let completeLabel: UILabel = {
        let label = UILabel()
        label.text = "할일 완료"
        return label
    }()
    
    private let completeSwitch: UISwitch = {
        let todoSwitch = UISwitch()
        todoSwitch.onTintColor = .black
        return todoSwitch
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 5
        button.backgroundColor = .black
        button.tintColor = .white
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
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
    
    // MARK: Private function
    
    @objc
    private func saveButtonTapped() {
        guard let todoText = todoTextField.text,
              todoText.isEmpty == false else {
            showAlert()
            return
        }
        
        if let todo {
            TodoList.update(todo: todo)
        } else {
            let todo: Todo = Todo(title: todoText, isDone: false)
            TodoList.addNew(todo: todo)
        }
        
        navigationController?.popViewController(animated: true)
    }
            
    private func showAlert() {
        let alertViewcontroller = UIAlertController(title: nil, message: "할일을 입력해주세요", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .cancel)
        alertViewcontroller.addAction(confirmAction)
        present(alertViewcontroller, animated: true)
    }

}

// MARK: - UI Fucitons

extension TodoDetailViewController {
    
    private func configureUI () {
        view.backgroundColor = .white
        titleLabel.text = todo == nil ?  "할일 입력" : "할일 수정"
        todoTextField.text = todo?.title
        completeSwitch.isOn = todo?.isDone ?? false
        saveButton.setTitle(todo == nil ?  "저장하기" : "수정하기", for: .normal)
    }
    
    private func createLayout() {
        [titleLabel, todoStackView, completionStackView, saveButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [todoLabel, todoTextField].forEach {
            todoStackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [completeLabel, completeSwitch].forEach {
            completionStackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.Padding.leading),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Layout.Padding.trailing),
            
            todoStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Layout.Padding.top),
            todoStackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            todoStackView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            todoStackView.heightAnchor.constraint(equalToConstant: Layout.Size.textFieldHeight),
            
            completionStackView.topAnchor.constraint(equalTo: todoStackView.bottomAnchor, constant: Layout.Padding.top),
            completionStackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            completionStackView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            completionStackView.heightAnchor.constraint(equalToConstant: Layout.Size.textFieldHeight),

            saveButton.topAnchor.constraint(equalTo: completionStackView.bottomAnchor, constant: Layout.Padding.top),
            saveButton.leadingAnchor.constraint(equalTo: completionStackView.leadingAnchor),
            saveButton.trailingAnchor.constraint(equalTo: completionStackView.trailingAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: Layout.Size.textFieldHeight)
        ])
    }
        
}


