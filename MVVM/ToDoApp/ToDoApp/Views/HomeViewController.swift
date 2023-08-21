//
//  ViewController.swift
//  ToDoApp
//
//  Created by Nick on 2023/03/31.
//

import UIKit
import Combine

final class HomeViewController: UIViewController {
    
    //MARK: - Properties
    
    private let viewModel = HomeViewModel()
    private var cancelBag = Set<AnyCancellable>()
    
    private let searchBar = SearchTextField()
    private let tableView =  UITableView(frame: .zero, style: .grouped)
    private let hideCompleteButton = UIButton(type: .system)
    private let addToDoButton = UIButton()
    private lazy var spinner = UIActivityIndicatorView(style: .medium)
    private lazy var refreshControl = UIRefreshControl()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.textField.delegate = self
        
        configureUI()
        createLayout()
        bindUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: - Bind UI with combine
    
    private func bindUI() {
        viewModel.$todoSectionList
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.tableView.reloadData()
                self.spinner.stopAnimating()
            }
            .store(in: &cancelBag)
        
        searchBar.textField.textDidChangePublisher
            .compactMap { $0.text }
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .assign(to: \.searchTerm, on: viewModel)
            .store(in: &cancelBag)
        
        searchBar.textField.textDidChangePublisher
            .compactMap { $0.text }
            .debounce(for: 1, scheduler: RunLoop.main)
            .sink(receiveValue: { [weak self] searchTerm in
                guard let self = self else { return }
                if searchTerm.isEmpty {
                    self.viewModel.fetchToDoList()
                } else {
                    self.viewModel.searchToDoList(with: searchTerm)
                }
            })
            .store(in: &cancelBag)
    }
    
    //MARK: - UI Function
    
    private func configureUI() {
        view.backgroundColor = .grayF7F8FA
        
        navigationItem.backButtonTitle = "닫기"
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.refreshControl = refreshControl
        tableView.tableFooterView = spinner
        tableView.tableFooterView?.isHidden = false
        tableView.register(ToDoCell.self, forCellReuseIdentifier: ToDoCell.identifier)

        
        addToDoButton.backgroundColor = .black
        addToDoButton.tintColor = .white
        let plusImage = UIImage(systemName: "plus")
        addToDoButton.setImage(plusImage, for: .normal)
        addToDoButton.layer.cornerRadius = 21
        addToDoButton.layer.masksToBounds = true
        addToDoButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        

        hideCompleteButton.setTitle("완료 숨기기", for: .normal)
        hideCompleteButton.tintColor = .systemBlue
        hideCompleteButton.backgroundColor = .clear
        hideCompleteButton.addTarget(self, action: #selector(hideCompleteButtonTapped), for: .touchUpInside)
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
  
    private func createLayout() {
        [searchBar, tableView, hideCompleteButton, addToDoButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -14),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            addToDoButton.widthAnchor.constraint(equalToConstant: 42),
            addToDoButton.heightAnchor.constraint(equalToConstant: 42),
            addToDoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            addToDoButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -34)
        ])
    }
    
}

//MARK: - Functions

extension HomeViewController {
    
    @objc private func refresh(_ sender: UIRefreshControl) {
        viewModel.refreshToDoList()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: { [weak self] in
            guard let self = self else { return }
            self.refreshControl.endRefreshing()
        })
    }
    
    @objc private func addButtonTapped() {
        let toDoViewController = ToDoViewController()
        navigationController?.pushViewController(toDoViewController, animated: true)
    }
    
    @objc private func hideCompleteButtonTapped() {
        viewModel.hideComplete()
        if viewModel.isHideCompleted {
            hideCompleteButton.setTitle("전체 할일 보기", for: .normal)
        } else {
            hideCompleteButton.setTitle("완료 숨기기", for: .normal)
        }
    }
    
}

//MARK: - TableView Datasoure

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.todoSectionList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.todoSectionList[section].todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoCell.identifier, for: indexPath) as? ToDoCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        let todoList = viewModel.todoSectionList[indexPath.section]
        let toDo = todoList.todos[indexPath.row]
        cell.bind(with: toDo)
        
        // TODO: - TodoDoneDelegate 컴바인과 연결
        cell.cancellable = cell.checkBtnTapSubject
            .sink { [weak self] toDo in
                guard let self = self else { return }
                self.viewModel.todoCompleted(toDo)
            }
        
        return cell
    }
    
    // TODO: - TableView Header 하드 코딩한 부분 바꾸기
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 60 : 41
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        headerView.backgroundColor = .grayF7F8FA
        
        let headerLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
            label.textColor = .black
            label.text = viewModel.todoSectionList[section].dateTitle
            return label
        }()
        
        headerView.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            headerLabel.topAnchor.constraint(equalTo: headerView.topAnchor),
        ])
        
        if section == 0 {
            headerView.addSubview(hideCompleteButton)
            hideCompleteButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                hideCompleteButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
                hideCompleteButton.bottomAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 5),
                hideCompleteButton.heightAnchor.constraint(equalToConstant: 16)
            ])
        }
        
        return headerView
    }
}

//MARK: - Tableview Delegate

extension HomeViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        spinner.startAnimating()
        let height = scrollView.frame.size.height
        let contentYOffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYOffset
        let triggerPoint = distanceFromBottom - 50
        if triggerPoint < height {
            viewModel.prefetchToDoList()
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let leftSlideAction = UIContextualAction(style: .normal, title: "수정") {[weak self] action, view, hanlder in
            guard let self = self else { return }
            let todoList = self.viewModel.todoSectionList[indexPath.section]
            let todoData = todoList.todos[indexPath.row]
            let toDoViewController = ToDoViewController(todoData: todoData)
            navigationController?.pushViewController(toDoViewController, animated: true)
        }
        leftSlideAction.backgroundColor = .systemBlue
        
        return UISwipeActionsConfiguration(actions: [leftSlideAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteSlideAction = UIContextualAction(style: .destructive, title: "삭제") { action, view, hanlder in
            
            let alert = UIAlertController(title: "안내", message: "할일을 삭제하시겠습니까?",
                                          preferredStyle: .alert)
            let submitAction = UIAlertAction(title: "확인", style: .destructive) {[weak self] _ in
                guard let self = self else { return }
                let todoList = self.viewModel.todoSectionList[indexPath.section]
                let todoData = todoList.todos[indexPath.row]
                guard let todoID = todoData.id else { return }
                self.viewModel.deleteTodo(id: todoID)
                
                // TODO: - Combine과 충돌할 가능성이 있지 않을까?
                let idPath = IndexPath(row: indexPath.row, section: indexPath.section)
                self.viewModel.todoSectionList[indexPath.section].todos.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [idPath], with: .middle)
            }
            let closeAction = UIAlertAction(title: "닫기", style: .cancel)
            alert.addAction(submitAction)
            alert.addAction(closeAction)
            
            self.present(alert, animated: true, completion: nil)
        }
        deleteSlideAction.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [deleteSlideAction])
    }
    
}

//MARK: - TextField Delegate

extension HomeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
}

//MARK: - comment

extension HomeViewController: TodoDoneDelegate {
    
    func todoDoneButtonTapped(_ toDo: ToDoModel) {
        viewModel.todoCompleted(toDo)
    }
    
}


//MARK: - Preview

#if DEBUG

import SwiftUI

struct HomeViewRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        HomeViewController()
    }
}

struct HomeViewRepresentable_PreviewProvider: PreviewProvider {
    static var previews: some View {
        HomeViewRepresentable()
            .previewDevice("iPhone 13")
            .ignoresSafeArea()
    }
}

#endif
