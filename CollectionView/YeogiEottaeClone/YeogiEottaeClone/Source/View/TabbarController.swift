//
//  TabbarController.swift
//  YeogiEottaeClone
//
//  Created by Nick on 2023/06/26.
//

import UIKit

class TabbarController: UITabBarController {
    
    // MARK: - ViewControllers
    
    let homeViewController = UINavigationController(rootViewController: HomeViewController())
    let searchViewController = UINavigationController(rootViewController: SearchViewController())
    let locationViewController = UINavigationController(rootViewController: LocationViewController())
    let likedViewController = UINavigationController(rootViewController: LikedViewController())
    let profileViewController = UINavigationController(rootViewController: ProfileViewController())
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViewControllers([homeViewController, searchViewController, locationViewController, likedViewController, profileViewController], animated: true)
        changeTabbarAttribute()
    }
    
    override func viewDidLayoutSubviews() {
        changeTabbarHeight(90)
    }
    
    // MARK: - Function
    
    private func changeTabbarHeight(_ height: Double) {
        var newFrame = tabBar.frame
        newFrame.size.height = height
        newFrame.origin.y = view.frame.size.height - height
        tabBar.frame = newFrame
    }
    
    private func changeTabbarAttribute() {
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .white
        tabBar.tintColor = .systemPink
        
        if let tabbarItemList = tabBar.items {
            tabbarItemList[0].image = UIImage(systemName: "house.fill")
            tabbarItemList[0].title = "홈"
            
            tabbarItemList[1].image = UIImage(systemName: "magnifyingglass")
            tabbarItemList[1].title = "검색"
            
            tabbarItemList[2].image = UIImage(systemName: "mappin")
            tabbarItemList[2].title = "주변"
            
            tabbarItemList[3].image = UIImage(systemName: "heart.fill")
            tabbarItemList[3].title = "찜"
            
            tabbarItemList[4].image = UIImage(systemName: "face.smiling.inverse")
            tabbarItemList[4].title = "내 정보"
            
            tabbarItemList.forEach { $0.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)}
        }
    }

}
