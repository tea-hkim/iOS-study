//
//  CollectionViewDataSource.swift
//  FlowLayout
//
//  Created by 김태호 on 12/9/23.
//

import UIKit

final class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Emoji.shared.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = Emoji.shared.sections[section]
        let itemList = Emoji.shared.items[section]
        return itemList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseableIdentifier, for: indexPath) as? CollectionViewCell else {
            fatalError("Cell is not created")
        }
        let section = Emoji.shared.sections[indexPath.section]
        let emoji = Emoji.shared.items[section]?[indexPath.row]
        
        cell.emojiLabel.text = emoji
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionHeaderView.reusableIdentifier, for: indexPath) as? CollectionHeaderView else {
            fatalError("HeaderView in not created")
        }
        let section = Emoji.shared.sections[indexPath.section]
        headerView.headerTitleLabel.text = section.rawValue
        
        return headerView
    }

    
}
