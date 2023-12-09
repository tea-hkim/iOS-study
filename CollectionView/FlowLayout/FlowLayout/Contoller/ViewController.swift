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

}

