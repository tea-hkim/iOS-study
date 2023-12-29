//
//  ContentView.swift
//  KakaoLoginPractice
//
//  Created by 김태호 on 12/17/23.
//

import SwiftUI
import KakaoSDKUser

struct ContentView: View {
    private let title: String = "카카오 로그인"
    var body: some View {
        VStack {
            Text(title)
                .bold()
                .font(.title)
            
            Button("카카오 로그인") {
                 loginWithKakao()
            }
        }
        .padding()
    }
    
    func loginWithKakao() {
        
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    _ = oauthToken
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        print("loginWithKakaoAccount() success.")

                        //do something
                        _ = oauthToken
                    }
                }
        }
        
        
    }
    
}

#Preview {
    ContentView()
}
