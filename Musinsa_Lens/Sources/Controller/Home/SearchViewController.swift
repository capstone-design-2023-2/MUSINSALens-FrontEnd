//
//  SearchViewController.swift
//  Musinsa_Lens
//
//  Created by 박예린 on 2023/11/20.
//

import UIKit
import KakaoSDKUser

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet var lensButton: UIButton!;
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setupNavigationBar()
        setupLayout()
        
        // 그림자 설정
        lensButton.layer.shadowColor = UIColor.black.cgColor
        lensButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        lensButton.layer.shadowOpacity = 0.5
        lensButton.layer.shadowRadius = 2
    }

    
    // MARK: - Custom Function
    func setupNavigationBar() {
            navigationController?.navigationBar.barTintColor = .black
            navigationItem.title = "무신사렌즈"
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
    
    
    // MARK: - Action Function
    
    // 렌즈버튼을 누르는 동안 -> 투명도: 0.5
    @IBAction func lensbuttonTouchDown() {
            lensButton.alpha = 0.5
        }
        
    // 렌즈버튼에서 손 때는 순간 -> 화면전환(MethodViewController)
    @IBAction func lensButtonTouchUp(_ sender: Any) {
        lensButton.alpha = 1.0
        guard let nextVC =  self.storyboard?.instantiateViewController(withIdentifier:"MethodVC")else{return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // 로그아웃 버튼
    @IBAction func unlinkClicked(_ sender: Any) {
    UserApi.shared.unlink {(error) in
        if let error = error {
            print(error)
        }
        else {
            print("unlink() success.")

            // 화면전환 -> LoginViewController
            guard let nextVC =  self.storyboard?.instantiateViewController(withIdentifier:"LoginVC")else{return}
            self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
    }
}
    
    // AutoLayout 설정 함수
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
        ])
    }
    
    // MARK: - ? Function
    

