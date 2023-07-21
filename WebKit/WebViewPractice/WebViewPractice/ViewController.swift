//
//  ViewController.swift
//  WebViewPractice
//
//  Created by Nick on 2023/06/12.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - UI Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var zipCodeTextField: UITextField!

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Functions
    
    @IBAction func buttonTapped(_ sender: UIButton) {
//        let webVC = KAKAOWebViewController()
        let webVC = WebViewController()
        webVC.modalPresentationStyle = .fullScreen
        present(webVC, animated: true)
    }
    
    private func configureUI() {
        titleLabel.text = "우편번호"
        
        zipCodeTextField.keyboardType = .numberPad
        zipCodeTextField.placeholder = "우편번호를 입력하세요"
    }

}

extension ViewController: SendDataDelegate {
    func sendData(data: String) {
        zipCodeTextField.text = data
    }
}
