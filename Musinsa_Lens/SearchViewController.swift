//
//  SearchViewController.swift
//  Musinsa_Lens
//
//  Created by 박예린 on 2023/11/20.
//

import UIKit
import KakaoSDKUser

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    var searchBar: UISearchBar! // UISearchBar 인스턴스를 저장할 변수 선언
    
    @IBOutlet weak var KeywordLocation: UILabel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchBar()
        setupLensButton()
        setupKeywordButton()
        setupLayout()
    }

    
    // MARK: - Custom Function Part
    
    // UISearchBar 설정 함수
    private func setupSearchBar() {
        // UISearchBar 인스턴스 생성
        searchBar = UISearchBar() // UISearchBar 객체 생성
        searchBar.delegate = self // 현재 뷰 컨트롤러가 UISearchBarDelegate 프로토콜을 따르도록 설정
        searchBar.placeholder = "키워드를 검색하세요" // 검색 바에 표시될 플레이스홀더 설정
        navigationItem.titleView = searchBar // 네비게이션 바의 titleView에 검색 바 추가
    }
    
    // LensButton 설정 함수
    private func setupLensButton() {
        // 이미지를 사용한 커스텀 버튼을 만들고 네비게이션 바에 추가
        let customSearchButton = UIButton(type: .custom)
        customSearchButton.setImage(UIImage(named: "lens-icon"), for: .normal)
        customSearchButton.addTarget(self, action: #selector(lensButtonTapped), for: .touchUpInside)

        let customSearchBarButtonItem = UIBarButtonItem(customView: customSearchButton)
        self.navigationItem.rightBarButtonItem = customSearchBarButtonItem
    }
    
    
    // LensButton 눌렸을 때 호출 -> 화면전환(MethodViewController)
    @objc func lensButtonTapped() {
        guard let nextVC =  self.storyboard?.instantiateViewController(withIdentifier:"MethodVC")else{return}
            self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // KeywordButton 설정 함수
    private func setupKeywordButton() {
        // 수평 스택 뷰 생성
        let stackView = UIStackView()
        stackView.axis = .horizontal // 수평으로 배치
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 7 // 뷰 사이의 간격

        // 1번째 버튼
        let button1 = UIButton(type: .system)
        button1.backgroundColor = CustomColor.lightgray
        button1.setTitleColor(.black, for: .normal)
        button1.layer.cornerRadius = 15 // 둥근 모양을 위한 코너 반지름 설정
        button1.setTitle("몇번", for: .normal)
        adjustButtonSize(button1)

        // 2번째 버튼
        let button2 = UIButton(type: .system)
        button2.backgroundColor = CustomColor.lightgray
        button2.setTitleColor(.black, for: .normal)
        button2.layer.cornerRadius = 15 // 둥근 모양을 위한 코너 반지름 설정
        button2.setTitle("몇번째", for: .normal)
        adjustButtonSize(button2)
        
        // 3번째 버튼
        let button3 = UIButton(type: .system)
        button3.backgroundColor = CustomColor.lightgray
        button3.setTitleColor(.black, for: .normal)
        button3.layer.cornerRadius = 15 // 둥근 모양을 위한 코너 반지름 설정
        button3.setTitle("몇번째 버튼", for: .normal)
        adjustButtonSize(button3)
        
        // 4번째 버튼
        let button4 = UIButton(type: .system)
        button4.backgroundColor = CustomColor.lightgray
        button4.setTitleColor(.black, for: .normal)
        button4.layer.cornerRadius = 15 // 둥근 모양을 위한 코너 반지름 설정
        button4.setTitle("몇번째 버튼일까요?", for: .normal)
        adjustButtonSize(button4)
        
        // 5번째 버튼
        let button5 = UIButton(type: .system)
        button5.backgroundColor = CustomColor.lightgray
        button5.setTitleColor(.black, for: .normal)
        button5.layer.cornerRadius = 15 // 둥근 모양을 위한 코너 반지름 설정
        button5.setTitle("몇번째 버튼일까요?", for: .normal)
        adjustButtonSize(button5)
        
        // 6번째 버튼
        let button6 = UIButton(type: .system)
        button6.backgroundColor = CustomColor.lightgray
        button6.setTitleColor(.black, for: .normal)
        button6.layer.cornerRadius = 15 // 둥근 모양을 위한 코너 반지름 설정
        button6.setTitle("몇번째 버튼일까요?", for: .normal)
        adjustButtonSize(button6)
        

        // 스택 뷰에 버튼들 추가
        stackView.addArrangedSubview(button1)
        stackView.addArrangedSubview(button2)
        stackView.addArrangedSubview(button3)
        stackView.addArrangedSubview(button4)
        stackView.addArrangedSubview(button5)
        stackView.addArrangedSubview(button6)
        
        // 루트 뷰에 스택 뷰 추가
        view.addSubview(stackView)
        
        // Auto Layout 설정
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: KeywordLocation.bottomAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        
        // 버튼 크기 조절 함수
        func adjustButtonSize(_ button: UIButton) {
            let horizontalPadding: CGFloat = 15.0
            button.contentEdgeInsets = UIEdgeInsets(top: 7, left: horizontalPadding, bottom: 5, right: horizontalPadding)
        }
    }
    
    // AutoLayout 설정 함수
    private func setupLayout() {
        NSLayoutConstraint.activate([
        
        ])
    }
    
    // MARK: - Action Function Part
    
    // 로그아웃 버튼
    @IBAction func unlinkClicked(_ sender: Any) {

            // 연결 끊기 : 연결이 끊어지면 기존의 토큰은 더 이상 사용할 수 없으므로, 연결 끊기 API 요청 성공 시 로그아웃 처리가 함께 이뤄져 토큰이 삭제됩니다.
            UserApi.shared.unlink {(error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("unlink() success.")

                    // 연결끊기 시 메인으로 보냄
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
}

