//
//  DetailEmojiViewController.swift
//  FlowLayout
//
//  Created by 김태호 on 12/9/23.
//

import UIKit

class DetailEmojiViewController: UIViewController {
    
    var emojiText: String?
    
    @IBOutlet weak var emojiLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        emojiLabel.text = emojiText
    }
    

}
