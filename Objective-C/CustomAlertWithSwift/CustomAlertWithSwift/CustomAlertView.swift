//
//  AlertCCustomAlertViewontroller.swift
//  CustomAlertWithSwift
//
//  Created by 김태호 on 2023/06/27.
//

import UIKit

enum AlertType {
    case mustUpdate
    case update
}

@objc
class CustomAlertView: UIViewController {
    
    // MARK: - Property
    
    private let backgroundView = UIView()
    private let alertView = UIView()
    private let titleLabel = UILabel()
    private let divideLine = UIView()
    private let contentLabel = UILabel()
    private let buttonStack = UIStackView()
    private let confirmButton = UIButton()
    private let cancelButton = UIButton()
    
    private var titleText: String?
    private var contentText: String
    private var confirmText: String
    private var cancelText: String?
    
    private enum LayoutConstant {
        static let leading: CGFloat = 20
        static let trailing: CGFloat = -20
        static let space: CGFloat = 10
        static let buttonSpace: CGFloat = 15
    }
    
    // MARK: - Lifecycle
    
    
    @objc
    init(title: String, content: String, confirmText: String, cancelText: String) {
        self.titleText = title
        self.contentText = content
        self.confirmText = confirmText
        self.cancelText = cancelText
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        setLayout()
    }
    
    // MARK: - UI Function
    
    private func setConstraints() {
        backgroundView.backgroundColor = .black.withAlphaComponent(0.5)
        
        alertView.backgroundColor = .white
        alertView.layer.cornerRadius = 5
        alertView.layer.masksToBounds = true
        
        titleLabel.text = titleText
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textAlignment = .center
        
        divideLine.backgroundColor = .systemGray3
        
        contentLabel.text = contentText
        contentLabel.font = .systemFont(ofSize: 17, weight: .regular)
        contentLabel.numberOfLines = 0
        
        buttonStack.axis = .horizontal
        buttonStack.spacing = LayoutConstant.space
        buttonStack.distribution = .fillEqually
        
        confirmButton.setTitle(confirmText, for: .normal)
        confirmButton.backgroundColor = .systemBlue
        confirmButton.tintColor = .white
        confirmButton.layer.cornerRadius = 5
        confirmButton.layer.masksToBounds = true
        
        cancelButton.setTitle(cancelText, for: .normal)
        cancelButton.backgroundColor = .systemGray6
        cancelButton.setTitleColor(.darkGray, for: .normal)
        cancelButton.layer.cornerRadius = 5
        cancelButton.layer.masksToBounds = true
        
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    private func setLayout() {
        [backgroundView, alertView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        [titleLabel, divideLine, contentLabel, buttonStack].forEach {
            alertView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        [confirmButton, cancelButton].forEach {
            buttonStack.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            alertView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            alertView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            alertView.heightAnchor.constraint(greaterThanOrEqualToConstant: 250),
            alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -20),
            
            divideLine.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            divideLine.leadingAnchor.constraint(equalTo: alertView.leadingAnchor),
            divideLine.trailingAnchor.constraint(equalTo: alertView.trailingAnchor),
            divideLine.heightAnchor.constraint(equalToConstant: 1),
            
            contentLabel.topAnchor.constraint(equalTo: divideLine.bottomAnchor, constant: 10),
            contentLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 20),
            contentLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -20),
            contentLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            buttonStack.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 10),
            buttonStack.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 20),
            buttonStack.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -20),
            buttonStack.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -20),
        ])
        
    }
    
    // MARK: - Function
    
    @objc
    private func confirmButtonTapped() {
        print("✅✅✅✅✅✅✅ confirmButton Tapped ✅✅✅✅✅✅✅")
        self.dismiss(animated: false) {
            
        }
    }
    
    @objc
    private func cancelButtonTapped() {
        print("❎❎❎❎❎❎ cancelButton Tapped ❎❎❎❎❎❎")
        self.dismiss(animated: false) {
            
        }
    }
    

}
