//
//  MethodViewController.swift
//  Musinsa_Lens
//
//  Created by 박예린 on 2023/11/20.
//

import UIKit

class MethodViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
    }

    // MARK: - Private Methods

    private func setupNavigationBar() {
        // 네비게이션 바 색상 설정
        navigationController?.navigationBar.barTintColor = .black
        
        // 네비게이션 바 타이틀 설정
        navigationItem.title = "무신사렌즈"
        
        // 네비게이션 바 타이틀 색상 설정
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black
        ]
        navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
    }

    // MARK: - Navigation

    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
