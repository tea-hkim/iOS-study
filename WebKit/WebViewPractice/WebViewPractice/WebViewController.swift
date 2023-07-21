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
    
    private let kakaoUrlString: String = "https://tea-hkim.github.io/KAKAO-Zipcode/"
    private var webView: WKWebView?
    private let indicator = UIActivityIndicatorView(style: .medium)
    private var address = ""
    weak var delegate: SendDataDelegate?
    var popUpView: WKWebView?
    
    override func loadView() {
        let contentController = WKUserContentController()
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.userContentController = contentController
        contentController.add(self, name: "callBackHandler")
        
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView?.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttributes()
        setContraints()
        
        guard let url = URL(string: kakaoUrlString),
              let webView = webView else { return }
        let request = URLRequest(url: url)
        webView.load(request)
        indicator.startAnimating()
    }
    
    private func setAttributes() {
        view.backgroundColor = .white
    }
    
    private func setContraints() {
        guard let webView = webView else { return }
        
        webView.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: webView.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: webView.centerYAnchor),
        ])
        
    }
    
}

extension WebViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if let data = message.body as? [String: Any] {
            print("data : \(data)")
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


