//
//  InerWebViewController.swift
//  WebViewPractice
//
//  Created by Nick on 2023/06/13.
//

import UIKit
import WebKit

class KAKAOWebViewController: UIViewController {
    
    // MARK: - Properties
    
    private let modalHeaderViewHeight: CGFloat = 100
    
    // MARK: - UI Properties
    
    private var upperView: UIView?
    private var webView: WKWebView?
    private var openWebView: WKWebView?
    private var popUpView: PopupView?
    private let indicator = UIActivityIndicatorView(style: .medium)
    private let closeButtonHeight = CGFloat(100)
    
    // MARK: - Lifecycle
    
    override func loadView() {
        let configuration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: configuration)
        webView?.uiDelegate = self
        webView?.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        webView?.isInspectable = true
    }
    
    // MARK: - UI Functions
    
    private func configureUI() {
        setAttributes()
        setContraints()
    }
    
    private func setAttributes() {
        view.backgroundColor = .white
        webView?.configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        
        guard let url = URL(string: "https://postcode.map.daum.net/guide#sample") else { return }
        let request = URLRequest(url: url)
        
        guard let webView else { return }
        webView.load(request)
        indicator.startAnimating()
    }
    
    private func setContraints() {
        guard let webView else { return }
        webView.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: webView.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: webView.centerYAnchor),
        ])
    }
}

// MARK: - WKNavigationDelegate

extension KAKAOWebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        indicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.stopAnimating()
    }
    
}


// MARK: - WebView에서 새로 열리는 창 처리
extension KAKAOWebViewController: WKUIDelegate {
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        
        openWebView = WKWebView(frame: CGRect(x: 0, y: modalHeaderViewHeight, width: view.bounds.width, height: view.bounds.height - modalHeaderViewHeight), configuration: configuration)
        openWebView?.uiDelegate = self
        
        popUpView = PopupView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: modalHeaderViewHeight), webView: openWebView)
        
        guard let openWebView, let popUpView else { return WKWebView() }
        view.addSubview(openWebView)
        view.addSubview(popUpView)
        return self.openWebView
    }
    
    func webViewDidClose(_ webView: WKWebView) {
        // TODO: parent webView일 경우 닫히지 않도록 에러처리
        webView.removeFromSuperview()
        popUpView?.removeFromSuperview()
    }
    
}

