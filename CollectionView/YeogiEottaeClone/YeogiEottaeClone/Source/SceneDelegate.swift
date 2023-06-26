//
//  SceneDelegate.swift
//  YeogiEottaeClone
//
//  Created by Nick on 2023/06/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        window?.rootViewController = makeTabbarController()
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    private func makeTabbarController() -> UITabBarController {
        let homeViewController = UINavigationController(rootViewController: HomeViewController())
        let searchViewController = UINavigationController(rootViewController: SearchViewController())
        let locationViewController = UINavigationController(rootViewController: LocationViewController())
        let likedViewController = UINavigationController(rootViewController: LikedViewController())
        let profileViewController = UINavigationController(rootViewController: ProfileViewController())
        
        let tabbarViewController = UITabBarController()
        tabbarViewController.setViewControllers([homeViewController, searchViewController, locationViewController, likedViewController, profileViewController], animated: true)
        tabbarViewController.tabBar.isTranslucent = false
        tabbarViewController.tabBar.backgroundColor = .white
        tabbarViewController.tabBar.tintColor = .systemPink
        
        // change tab bar height
        tabbarViewController.tabBar.sizeThatFits(CGSize(width: tabbarViewController.view.frame.width,
                                                        height: 200))
        
        if let tabbarItemList = tabbarViewController.tabBar.items {
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
        
        return tabbarViewController
    }
    
}

