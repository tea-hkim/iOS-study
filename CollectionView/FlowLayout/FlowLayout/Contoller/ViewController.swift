//
//  ViewController.swift
//  FlowLayout
//
//  Created by 김태호 on 12/8/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    private let dataSource = CollectionViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = dataSource
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if isEditing { return false }
        return true
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
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        deleteButton.isHidden = !editing
        addButton.isHidden = editing
        
        collectionView.indexPathsForVisibleItems.forEach {
            guard let cell = collectionView.cellForItem(at: $0) as? CollectionViewCell else { return }
            cell.isEditing = editing
        }
        
        if !isEditing {
            collectionView.indexPathsForSelectedItems?.compactMap({ $0 }).forEach {
                collectionView.deselectItem(at: $0, animated: true)
            }
        }
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        Emoji.shared.addRandomEmoji(at: Emoji.shared.sections[0])
        let emojiCount = collectionView.numberOfItems(inSection: 0)
        let insertedIndex = IndexPath(item: emojiCount, section: 0)
        collectionView.insertItems(at: [insertedIndex])
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIBarButtonItem) {
        guard let selectedIndices = collectionView.indexPathsForSelectedItems else { return }
        let sectionsToDelete = Set(selectedIndices.map({ $0.section }))
        sectionsToDelete.forEach { section in
            let indexPathsForSection = selectedIndices.filter({ $0.section == section })
            let sortedIndexPaths = indexPathsForSection.sorted(by: { $0.item > $1.item })
            
            sortedIndexPaths.forEach { indexPath in
                let section = Emoji.shared.sections[indexPath.section]
                Emoji.shared.deleteEmoji(section: section, itemIndex: indexPath.item)
            }
            collectionView.deleteItems(at: sortedIndexPaths)
        }
    }
    
    
}

