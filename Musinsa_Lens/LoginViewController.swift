//
//  ViewController.swift
//  Musinsa_Lens
//
//  Created by 박예린 on 2023/11/19.
//

import UIKit
import KakaoSDKUser

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // 카카오톡으로 로그인
    @IBAction func loginWithKakaoTalk(){
        // 카카오톡 실행 가능 여부 확인
//        if (UserApi.isKakaoTalkLoginAvailable()) {
//            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
//                if let error = error {
//                    print(error)
//                }
//                else {
//                    print("loginWithKakaoTalk() success.")
//
//                    //do something
//                    _ = oauthToken
//                }
//            }
//        }
        // 카카오 계정으로 로그인
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
