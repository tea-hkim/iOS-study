//
//  SceneDelegate.swift
//  KakaoLoginPractice
//
//  Created by 김태호 on 12/18/23.
//

import UIKit
import KakaoSDKAuth


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }
    
}
