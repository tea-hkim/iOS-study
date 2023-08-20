//
//  ToDoViewController.swift
//  ToDoApp
//
//  Created by Nick on 2023/04/09.
//

import UIKit
import Combine

class ToDoViewController: UIViewController {
    
    //MARK: - Properties
    
    private let viewModel: ToDoViewModel
    
    private let titleLabel = UILabel()
    private let toDoLabel = UILabel()
    private let toDoTextField = UITextField()
    private let underLine = UIView()
    private let warningLabel = UILabel()
    private let completeLabel = UILabel()
    private let completeSwitch = UISwitch()
    private let completeButton = UIButton(type: .system)
    private let descriptionLabel = UILabel()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        createLayout()
    }
    
    init(todoData: ToDoModel? = nil) {
        viewModel = ToDoViewModel(todoData: todoData)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Function
    
    private func configureUI() {
        view.backgroundColor = .grayF7F8FA
        
        titleLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        
        toDoLabel.text = "할일"
        toDoLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        toDoTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        underLine.backgroundColor = .black
        underLine.alpha = 0.2
        
        warningLabel.textColor = .red
        warningLabel.text = "6글자 이상 입력해주세요"
        warningLabel.isHidden = true
        warningLabel.font = UIFont.systemFont(ofSize: 13)
        
        completeLabel.text = "완료"
        completeLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        completeButton.layer.cornerRadius = 11.58
        completeButton.setTitle("완료", for: .normal)
        completeButton.backgroundColor = .black
        completeButton.tintColor = .white
        completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        
        descriptionLabel.text = "If you disable today, the task will be considered as tomorrow"
        descriptionLabel.textColor = .gray3C43
        descriptionLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        descriptionLabel.numberOfLines = 0
        
        configureNavigationBar()
        
        if viewModel.todoData != nil {
            titleLabel.text = "할일 수정"
            toDoTextField.text = viewModel.todoData?.title
            completeSwitch.isOn = viewModel.todoData?.isDone ?? false
        } else {
            titleLabel.text = "할일 추가"
            toDoTextField.placeholder = "할일을 입력하세요."
        }
    }
    
    private func configureNavigationBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .grayF9
        
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.compactAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        
        navigationItem.title = viewModel.todoData == nil ? "할일 추가" : "할일 수정"
    }
    
    private func createLayout() {
        [titleLabel, toDoLabel, toDoTextField, underLine, warningLabel,
         completeLabel, completeSwitch, completeButton, descriptionLabel].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 37),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 29),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 49),
            
            toDoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 43),
            toDoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 29),
            toDoLabel.widthAnchor.constraint(equalToConstant: 38),
            
            toDoTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 39),
            toDoTextField.leadingAnchor.constraint(equalTo: toDoLabel.trailingAnchor, constant: 33),
            toDoTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34),
            
            // TODO: - textLabel anchor로 바꾸기
            underLine.topAnchor.constraint(equalTo: toDoTextField.bottomAnchor, constant: 14),
            underLine.leadingAnchor.constraint(equalTo: toDoLabel.trailingAnchor, constant: 33),
            underLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34),
            underLine.heightAnchor.constraint(equalToConstant: 0.38),
            
            warningLabel.topAnchor.constraint(equalTo: underLine.bottomAnchor, constant: 14),
            warningLabel.leadingAnchor.constraint(equalTo: toDoLabel.trailingAnchor, constant: 33),
            
            
            completeLabel.topAnchor.constraint(equalTo: toDoLabel.bottomAnchor, constant: 105),
            completeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 29),
            completeLabel.widthAnchor.constraint(equalToConstant: 38),
            
            completeSwitch.topAnchor.constraint(equalTo: underLine.bottomAnchor, constant: 90),
            completeSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34),
            
            completeButton.topAnchor.constraint(equalTo: completeLabel.bottomAnchor, constant: 62),
            completeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 29),
            completeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -29),
            completeButton.heightAnchor.constraint(equalToConstant: 46.32),
            
            descriptionLabel.topAnchor.constraint(equalTo: completeButton.bottomAnchor, constant: 14),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 29),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -29),
        ])
    }

}

//MARK: - Functions

extension ToDoViewController {
    
    @objc
    private func completeButtonTapped() {
        guard let todoTitle = toDoTextField.text else { return }
        if todoTitle.count < 6 {
            warningLabel.isHidden = false
            return
        }
        
        let isDone = completeSwitch.isOn
        if viewModel.todoData != nil {
            viewModel.editTodo(title: todoTitle, isDone: isDone)
        } else {
            viewModel.addTodo(title: todoTitle, isDone: isDone)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func textFieldDidChange() {
        if !warningLabel.isHidden {
            warningLabel.isHidden = true
        }
    }
    
}


#if DEBUG

import SwiftUI

struct ToDoViewRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        ToDoViewController()
    }
}

struct ToDoViewRepresentable_PreviewProvider: PreviewProvider {
    static var previews: some View {
        ToDoViewRepresentable()
            .previewDevice("iPhone 13")
            .ignoresSafeArea()
    }
}

#endif
