//
//  HeaderView.swift
//  MovieApp
//
//  Created by 김태호 on 2023/06/24.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    static let id = "HeaderView"
    
    // MARK: - UI Functions
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        
        return label
    }()
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    
    private func setConstraints() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
        }
    }
    
    func configureComponent(title: String) {
        titleLabel.text = title
    }
}
