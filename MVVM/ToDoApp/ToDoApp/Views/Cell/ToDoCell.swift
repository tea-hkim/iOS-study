//
//  ToDoCell.swift
//  ToDoApp
//
//  Created by Nick on 2023/04/09.
//

import Combine
import UIKit

protocol TodoDoneDelegate: AnyObject {
    func todoDoneButtonTapped(_ toDo: ToDoModel)
}

final class ToDoCell: UITableViewCell {
    
    //MARK: - Properties
    internal var cancellable: AnyCancellable?
    
    static let identifier = "ToDoCell"
    
    private var toDo: ToDoModel?
    
    private lazy var checkBoxButton = UIButton(type: .system)
    private lazy var toDoLabel = UILabel()
    private lazy var dateLabel = UILabel()
    
    //Output
    var checkBtnTapSubject = PassthroughSubject<ToDoModel, Never>()
    
    //MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        createLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Function
    
    func bind(with toDo: ToDoModel) {
        self.toDo = toDo
        
        guard let title = toDo.title,
              let timeString = toDo.getTimeToString() else { return }
        
        if let isDone = toDo.isDone, isDone == true {
            toDoLabel.attributedText = drawCancelLine(with: title)
            dateLabel.attributedText = drawCancelLine(with: timeString)
            toDoLabel.alpha = 0.2
            dateLabel.alpha = 0.3
            
            checkBoxButton.backgroundColor = .black
            checkBoxButton.layer.borderWidth =  0
            
            let configuration = UIImage.SymbolConfiguration(scale: .small)
            let checkImage = UIImage(systemName: "checkmark", withConfiguration: configuration)
            checkBoxButton.setImage(checkImage, for: .normal)
            checkBoxButton.tintColor = .white
        } else {
            toDoLabel.text = title
            dateLabel.text = timeString
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        toDoLabel.attributedText = nil
        dateLabel.attributedText = nil
        
        resetUI()
        cancellable?.cancel()
    }
    
    private func configureUI() {
        backgroundColor = .clear
        
        toDoLabel.textColor = UIColor.gray73
        toDoLabel.numberOfLines = 0
        dateLabel.textColor = UIColor(named: "grayA3")
        
        checkBoxButton.addTarget(self, action: #selector(checkBoxButtonTapped), for: .touchUpInside)
        
        resetUI()
    }
    
    private func createLayout() {
        [checkBoxButton, toDoLabel, dateLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            checkBoxButton.widthAnchor.constraint(equalToConstant: 20),
            checkBoxButton.heightAnchor.constraint(equalToConstant: 20),
            checkBoxButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkBoxButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            toDoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 13),
            toDoLabel.leadingAnchor.constraint(equalTo: checkBoxButton.trailingAnchor, constant: 13),
            toDoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: toDoLabel.bottomAnchor, constant: 13),
            dateLabel.leadingAnchor.constraint(equalTo: checkBoxButton.trailingAnchor, constant: 13),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -13),
        ])
    }
    
    private func resetUI() {
        toDoLabel.alpha = 1
        dateLabel.alpha = 1
        
        checkBoxButton.backgroundColor = .white
        checkBoxButton.layer.cornerRadius = 6
        checkBoxButton.layer.borderWidth =  2
        checkBoxButton.layer.borderColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1).cgColor
        checkBoxButton.layer.masksToBounds = true
        contentView.backgroundColor = .clear
    }
    
    private func drawCancelLine(with text: String) -> NSAttributedString? {
        let attributedString = NSMutableAttributedString(string: text)
        let range = NSMakeRange(0, attributedString.length)
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: range)
        
        return attributedString
    }
    
    //MARK: - Functions
    
    @objc private func checkBoxButtonTapped(_ sender: UIButton) {
        guard let toDo = toDo else { return }
//        delegate?.todoDoneButtonTapped(toDo)
        checkBtnTapSubject.send(toDo)
    }
    
}

//MARK: - Preview

#if DEBUG

import SwiftUI

struct ToDoCellRepresentable: UIViewRepresentable {
    func updateUIView(_ uiView: UIViewType, context: Context) { }
    func makeUIView(context: Context) -> some UIView {
        ToDoCell()
    }
}

struct ToDoCellRepresentable_PreviewProvider: PreviewProvider {
    static var previews: some View {
        ToDoCellRepresentable()
            .previewLayout(.fixed(width: 250, height: 80))
    }
}

#endif
