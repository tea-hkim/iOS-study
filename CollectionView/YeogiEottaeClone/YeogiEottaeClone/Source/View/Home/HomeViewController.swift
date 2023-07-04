//
//  HomeViewController.swift
//  YeogiEottaeClone
//
//  Created by Nick on 2023/06/26.
//

import UIKit

enum CollectionViewSection: Hashable {
    case domesticCategory(UIImage)
    case overseaCategory(UIImage)
    case marketingBanner
    case couponBanner
    case hotelHorizontal(String)
    case pansionHorizontal(String)
    case cityHorizontal(String)
    case overseaHorizontal(String)
}

enum CollectionViewItem: Hashable {
    case categroy
    case cityCategory
    case bannerImage
    case iconList
}

class HomeViewController: UIViewController {
    
    // MARK: - UI Property
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    
    // MARK: - Property
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
    }
    

}
