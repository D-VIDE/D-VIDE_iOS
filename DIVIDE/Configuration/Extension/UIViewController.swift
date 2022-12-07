//
//  UIViewController.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/07/04.
//

import UIKit
import SnapKit

var lastBottomAlertView: UIView!

extension UIViewController {
//    func clearFuncDismissKeyboardWhenTappedAround() {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector())
//    }
    func dismissKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
//        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(false)
        self.view.frame.origin.y = 0
    }
    func deleteGeusture() {
        self.view.removeGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard)))
    }
    func presentAlert(title: String, message: String? = nil,
                      isCancelActionIncluded: Bool = false,
                      preferredStyle style: UIAlertController.Style = .alert,
                      handler: ((UIAlertAction) -> Void)? = nil) {
        self.dismissIndicator()
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let actionDone = UIAlertAction(title: "확인", style: .default, handler: handler)
        alert.addAction(actionDone)
        if isCancelActionIncluded {
            let actionCancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alert.addAction(actionCancel)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentAlert(title: String, message: String? = nil,
                      isCancelActionIncluded: Bool = false,
                      preferredStyle style: UIAlertController.Style = .alert,
                      with actions: UIAlertAction ...) {
        self.dismissIndicator()
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        actions.forEach { alert.addAction($0) }
        if isCancelActionIncluded {
            let actionCancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alert.addAction(actionCancel)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func changeRootViewController(_ viewControllerToPresent: UIViewController) {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = viewControllerToPresent
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
        } else {
            viewControllerToPresent.modalPresentationStyle = .overFullScreen
            self.present(viewControllerToPresent, animated: true, completion: nil)
        }
    }
    
    func presentBottomAlert(message: String, target: ConstraintRelatableTarget? = nil) {
        if lastBottomAlertView != nil {
            lastBottomAlertView.removeFromSuperview()
        }
        
        let alertSuperview = UIView()
        lastBottomAlertView = alertSuperview
        alertSuperview.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        alertSuperview.layer.cornerRadius = 19
        alertSuperview.isHidden = true
    
        let alertLabel = UILabel()
        alertLabel.font = .AppleSDGothicNeo(.regular, size: 14)
        alertLabel.textColor = .white
        
        self.view.addSubview(alertSuperview)
        alertSuperview.snp.makeConstraints { make in
            make.bottom.equalTo(target ?? self.view.safeAreaLayoutGuide).offset(-44)
            make.centerX.equalToSuperview()
        }
        
        alertSuperview.addSubview(alertLabel)
        alertLabel.snp.makeConstraints { make in
            make.top.equalTo(11)
            make.bottom.equalTo(-10)
            make.leading.equalTo(19)
            make.trailing.equalTo(-19)
        }
        
        alertLabel.text = message
        alertSuperview.alpha = 1.0
        alertSuperview.isHidden = false
        UIView.animate(
            withDuration: 0.5,
            delay: 0.8,
            options: .curveEaseIn,
            animations: { alertSuperview.alpha = 0 },
            completion: { _ in
                alertSuperview.removeFromSuperview()
            }
        )
    }
    
    func childViewLayout(superview: UIView, viewController: UIViewController) {
        self.addChild(viewController)
        superview.addSubview(viewController.view)
        viewController.view.snp.makeConstraints { $0.edges.equalToSuperview() }
        viewController.didMove(toParent: self)
    }
    
    func showIndicator() {
        IndicatorView.shared.show()
        IndicatorView.shared.showIndicator()
    }
    
    @objc func dismissIndicator() {
        IndicatorView.shared.dismiss()
    }
    
//    func showLogInAlert() {
//        let alertVC = UIAlertController(title: "로그인이 필요합니다.", message: "로그인 하시겠습니까?", preferredStyle: .alert)
//        let yes = UIAlertAction(title: "예", style: .default) { _ in
//            self.navigationController?.changeRootViewController(UINavigationController(rootViewController: LogInViewController()))
//        }
//        let no = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
//
//        alertVC.addAction(yes)
//        alertVC.addAction(no)
//        self.present(alertVC, animated: true, completion: nil)
//    }
    
}


