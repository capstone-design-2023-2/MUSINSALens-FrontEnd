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
        
        let navigationController = UINavigationController(rootViewController: SearchViewController())
        
        // 네비게이션 바 타이틀 설정
        navigationItem.title = "무신사 렌즈"
    }

    // MARK: - Navigation

    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
