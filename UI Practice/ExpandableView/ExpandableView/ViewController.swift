//
//  ViewController.swift
//  ExpandableView
//
//  Created by Nick on 2023/10/17.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var upperView: UIStackView!
    @IBOutlet weak var buttonList: UIStackView!
    var isExpanded: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(upperViewTapped))
        upperView.addGestureRecognizer(tap)
    }
    
    @objc
    func upperViewTapped(_ sender: UITapGestureRecognizer) {
        print("Tapped")
        UIView.animate(withDuration: 0.2) {
            self.buttonList.isHidden = !self.isExpanded
            self.view.layoutIfNeeded()
       }
        isExpanded.toggle()
        
        print("remove")
    }
    
}

