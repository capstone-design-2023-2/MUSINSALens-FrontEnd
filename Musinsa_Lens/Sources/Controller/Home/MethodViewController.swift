//
//  MethodViewController.swift
//  Musinsa_Lens
//
//  Created by 박예린 on 2023/11/20.
//

import UIKit
import AVFoundation
import Mantis

class MethodViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var recommendButton: UIButton!
    
    let imagePicker = UIImagePickerController()
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var croppedImage: UIImage?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()

        imagePicker.delegate = self

        // 카메라 미리보기를 표시할 레이어 추가
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = .resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
        } catch {
            print(error)
        }
    }
    
    // MARK: - Action
    
    @IBAction func openGalleryButtonTapped(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.sourceType = .photoLibrary
            
            //imagePicker.allowsEditing = true
            
            present(imagePicker, animated: true, completion: nil)
        } else {
            print("Photo library is not available.")
        }
    }

    @IBAction func openCameraButtonTapped(_ sender: UIButton) {
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            // 카메라 열기
            let cameraViewController = UIImagePickerController()
            cameraViewController.delegate = self
            cameraViewController.sourceType = .camera
            
            //cameraViewController.allowsEditing = true
            
            present(cameraViewController, animated: true, completion: nil)
        } else {
            // 권한 요청
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                if granted {
                    // 권한이 허용되면 카메라 열기
                    DispatchQueue.main.async {
                        let cameraViewController = UIImagePickerController()
                        cameraViewController.delegate = self
                        cameraViewController.sourceType = .camera
                        
                        //cameraViewController.allowsEditing = true
                        
                        self.present(cameraViewController, animated: true, completion: nil)
                    }
                } else {
                    print("Camera access denied.")
                }
            })
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            //imageView.image = originalImage
            croppedImage = originalImage
            dismiss(animated: true) {
                self.openCropVC(image: originalImage)
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func setupNavigationBar() {
        
        // 네비게이션 바 타이틀 설정
        navigationItem.title = "무신사 렌즈"
    }
    
    @IBAction func recommendButtonTapped(_ sender: UIButton) {

//        sendImageToServer { [weak self] in
//            guard let self = self else { return }
//            // RecommendViewController를 Storyboard에서 가져오기
//            if let recommendViewController = storyboard?.instantiateViewController(withIdentifier: "RecommendationViewControllerIdentifier") as? RecommendViewController {
//                    recommendViewController.croppedImage = croppedImage
//                    navigationController?.pushViewController(recommendViewController, animated: true)
//            }
        sendImageToServer { [weak self] in
            guard let self = self else { return }
            if let sendCroppedImage = self.croppedImage?.pngData() {
                NotificationCenter.default.post(
                    name: NSNotification.Name("ImageNotification"),
                    object: sendCroppedImage
                )
                        
                // RecommendViewController를 Storyboard에서 가져오기
                if let recommendViewController = self.storyboard?.instantiateViewController(
                    withIdentifier: "RecommendationViewControllerIdentifier"
                ) as? RecommendViewController {
                    recommendViewController.croppedImage = self.croppedImage
                    self.navigationController?.pushViewController(
                        recommendViewController,
                        animated: true
                    )
                }
            }
        }
    }
    
    private func sendImageToServer(completion: @escaping() -> Void) {
        guard let croppedImage = croppedImage else {
            print("Error: MVCnil")
            return
        }
        RecommendDataService.shared.getRecommendData_default(image: croppedImage) { response in
            // 서버 응답에 따른 처리
            switch response {
            case .success(let data):
                // 성공적으로 데이터를 받아온 경우
                if let response = data as? RecommendDataModel, let data = response.data {
                    print("업로드 성공")
                    completion()
                }
            case .requestErr(let message):
                print(message)
            case .networkFail:
                print("networkFail")
            case .serverErr:
                print("serverErr")
            case .pathErr:
                print("pathErr")
            case .decodingFail:
                print("decodingErr")
            }
            
            completion()
        }
    }
}


extension MethodViewController: CropViewControllerDelegate {
    
    func cropViewControllerDidCrop(_ cropViewController: Mantis.CropViewController, cropped: UIImage, transformation: Mantis.Transformation, cropInfo: Mantis.CropInfo) {
        
        croppedImage = cropped
        imageView.image = cropped
        //sendImageToServer {
        cropViewController.dismiss(animated: true, completion: nil)
        //}
    }
    
    func cropViewControllerDidCancel(_ cropViewController: Mantis.CropViewController, original: UIImage) {
        cropViewController.dismiss(animated: true, completion: nil)
    }
    
    private func openCropVC(image: UIImage) {
            
        let cropViewController = Mantis.cropViewController(image: image)
        cropViewController.delegate = self
        cropViewController.modalPresentationStyle = .fullScreen
        self.present(cropViewController, animated: true)
    }
    
}
