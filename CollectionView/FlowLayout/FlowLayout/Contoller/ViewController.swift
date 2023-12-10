//
//  ViewController.swift
//  FlowLayout
//
//  Created by 김태호 on 12/8/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let dataSource = CollectionViewDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = dataSource
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showDetailEmoji",
              let detailEmojiViewController = segue.destination as? DetailEmojiViewController,
              let cell = sender as? CollectionViewCell,
              let indexPath = collectionView.indexPath(for: cell) else {
            return
        }

        let section = Emoji.shared.sections[indexPath.section]
        let item = Emoji.shared.items[section]?[indexPath.item]
        
        detailEmojiViewController.emojiText = item
    }

}

