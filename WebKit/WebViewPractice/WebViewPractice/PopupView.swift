//
//  PopupView.swift
//  WebViewPractice
//
//  Created by Nick on 2023/06/23.
//

import UIKit
import WebKit

class PopupView: UIView {
    
    // MARK: - Properties
    
    private let headerView = UIView()
    private let closeButton = UIButton(type: .close)
    private let webView: WKWebView?
    
    // MARK: - Lifecycle
    
    init(frame: CGRect, webView: WKWebView?) {
        self.webView = webView
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        configureUI()
        setConstraint()
    }
        
    // MARK: - Functions
    
    private func configureUI() {
        headerView.backgroundColor = .gray
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    private func setConstraint() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(headerView)
        headerView.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 100),
            
            closeButton.heightAnchor.constraint(equalToConstant: 35),
            closeButton.widthAnchor.constraint(equalToConstant: 35),
            closeButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
            closeButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -15),
        ])
        
    }
    
    @objc
    private func closeButtonTapped() {
//        self.webView?.evaluateJavaScript("javascript:window.close()")
        
        self.webView?.removeFromSuperview()
        self.removeFromSuperview()
    }
    
}
