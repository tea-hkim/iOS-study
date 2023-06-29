//
//  WebViewController.swift
//  WebViewPractice
//
//  Created by Nick on 2023/06/12.
//

import UIKit
import WebKit

protocol SendDataDelegate: AnyObject {
    func sendData(data: String)
}

class WebViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private var webView: WKWebView?
    private let indicator = UIActivityIndicatorView(style: .medium)
    private var address = ""
    weak var delegate: SendDataDelegate?
    var popUpView: WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttributes()
        setContraints()
    }
    
    private func setAttributes() {
        view.backgroundColor = .white
        
        let contentController = WKUserContentController()
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = contentController
        contentController.add(self, name: "callBackHandler")
        
        webView = WKWebView(frame: .zero, configuration: configuration)
        webView?.navigationDelegate = self
        
        webView?.configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        
        guard let url = URL(string: "https://tea-hkim.github.io/KAKAO-Zipcode/") else { return }
        
        let request = URLRequest(url: url)
        
        guard let webView else { return }
        webView.load(request)
        indicator.startAnimating()
    }
    
    private func setContraints() {
        // TODO: loadView에서
        guard let webView = webView else { return }
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        webView.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            indicator.centerXAnchor.constraint(equalTo: webView.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: webView.centerYAnchor),
        ])
        
    }
    
}

extension WebViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if let data = message.body as? [String: Any] {
            address = data["roadAddress"] as? String ?? ""
        }
        delegate?.sendData(data: address)
        self.dismiss(animated: true, completion: nil)
    }
}

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        indicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.stopAnimating()
    }
    
}


