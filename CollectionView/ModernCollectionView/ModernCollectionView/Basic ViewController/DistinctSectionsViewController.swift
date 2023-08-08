//
//  DistinctSectionsViewController.swift
//  ModernCollectionView
//
//  Created by Nick on 2023/08/08.
//

import UIKit

final class DistinctSectionsViewController: UIViewController {
    
    private var collectionView: UICollectionView?
//    private var diffableDataSource: UICollectionViewDiffableDataSource<>
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

// MARK: - Configure CollectionView

extension DistinctSectionsViewController {
    
    enum Section {
        case list, grid5, grid3
        var columnCount: Int {
            switch self {
            case .list:
                return 1
            case .grid5:
                return 5
            case .grid3:
                return 3
            }
        }
    }
    
}
