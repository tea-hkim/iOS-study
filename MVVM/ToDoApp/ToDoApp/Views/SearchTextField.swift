//
//  SearchTextField.swift
//  ToDoApp
//
//  Created by Nick on 2023/04/09.
//

import UIKit

class SearchTextField: UIView {
    
    //MARK: - Properties
    
    let textField = UITextField()
    private let leftImage = UIImageView()
    
    //MARK: - Lifecycle

    public init() {
        super.init(frame: .zero)
        configureUI()
        createLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Function
    
    private func configureUI() {
        backgroundColor = .whiteFB
        
        textField.tintColor = .black
        textField.clearButtonMode = .whileEditing
        
        layer.cornerRadius = 20
        // TODO: - UIColor 전달방식 변경하기
        layer.borderColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1).cgColor
        layer.borderWidth = 1
        layer.masksToBounds = true
        
        leftImage.image = UIImage(systemName: "magnifyingglass",
                                  withConfiguration: UIImage.SymbolConfiguration(weight: .medium))
        leftImage.tintColor = .gray
        
        textField.attributedPlaceholder = NSAttributedString(string: "할일 검색",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        

    }
    
    private func createLayout() {
        [textField, leftImage].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            leftImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 11),
            leftImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            leftImage.widthAnchor.constraint(equalToConstant: 16),
            leftImage.heightAnchor.constraint(equalToConstant: 16),
            
            textField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: leftImage.trailingAnchor, constant: 13),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }
    
}

