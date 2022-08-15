////
////  PostRecruitingImgClass.swift
////  DIVIDE
////
////  Created by 정지윤 on 2022/08/15.
////
//
//import Foundation
//import Then
//import SnapKit
//import UIKit
//
//class PostRecruitingImgClss: NSObject {
//
//    var index: Int?
//
//    lazy var imgForUpload = UIImageView().then {
//        $0.image = UIImage(named: "defaultPhoto")
//        $0.clipsToBounds = true
//        $0.layer.cornerRadius = 13
//
//        $0.snp.makeConstraints { make in
//            make.height.equalTo(71)
//            make.width.equalTo(imgWidth)
//        }
//    }
//    lazy var imgUploadView = UIView().then {
//        $0.tag = 0
//        $0.backgroundColor = .clear
//        $0.isUserInteractionEnabled = true
//        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectPhoto(_:))))
//    }
//
//
//    @objc func selectPhoto(_ sender: UIView) {
//        print("photo selected")
//        let imagePicker = UIImagePickerController()
//        imagePicker.sourceType = .photoLibrary
//        imagePicker.delegate = self //3
//        // imagePicker.allowsEditing = true
//        present(imagePicker, animated: true)
//    }
//}
//
//extension PostRecruitingImgClss: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//
//            //img 변경
//            imgForUpload.image = pickedImage
//
//        }
//        dismiss(animated: true, completion: nil)
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        dismiss(animated: true, completion: nil)
//    }
//}
