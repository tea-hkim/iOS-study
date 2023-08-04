//
//  TwoColumnViewController.swift
//  ModernCollectionView
//
//  Created by Nick on 2023/08/04.
//

import UIKit

class TwoColumnViewController: UIViewController {
    
    // MARK: - Property
    
    private var collectionView: UICollectionView?
    private var dataSource: UICollectionViewDiffableDataSource<Section, Int>? = nil
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierachy()
        configureDataSource()
        makeSnapShot()
    }
    
}

// MARK: - Configure Layout

extension TwoColumnViewController {
    
    enum Section {
        case Column
    }
    
    private func configureHierachy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView?.backgroundColor = .yellow
        view.addSubview(collectionView ?? UICollectionView())
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let groupColumnCount = 2
        let groupWithFraction: CGFloat = 1.0 / CGFloat(groupColumnCount)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(groupWithFraction), heightDimension: .absolute(60))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: groupColumnCount)
        
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }

    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<TextCell, Int> { (cell, indexPath, identifier) in
            cell.configureComponent(with: "\(identifier)")
        }
        
        guard let collectionView else { return }
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView, cellProvider: {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        })
    }
    
    private func makeSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.Column])
        snapshot.appendItems(Array(0..<100))
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
}
