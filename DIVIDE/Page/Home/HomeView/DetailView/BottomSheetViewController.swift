//
//  BottomSheetView.swift
//  DIVIDE
//
//  Created by 임우섭 on 2022/08/19.
//

import UIKit
import SnapKit

final class BottomSheetView: PassThroughView {
  // MARK: Constants
  enum Mode {
    case tip
    case full
  }
  private enum Const {
    static let duration = 0.5
    static let cornerRadius = 12.0
    static let barViewTopSpacing = 7.0
    static let barViewSize = CGSize(width: UIScreen.main.bounds.width * 0.1, height: 3.0)
    static let bottomSheetRatio: (Mode) -> Double = { mode in
      switch mode {
      case .tip:
        return 0.32 // 위에서 부터의 값 (밑으로 갈수록 값이 커짐)
      case .full:
        return 0.2
      }
    }
    static let bottomSheetYPosition: (Mode) -> Double = { mode in
      Self.bottomSheetRatio(mode) * UIScreen.main.bounds.height
    }
  }
  
  // MARK: UI
    let bottomSheetView = UIView().then {
        $0.backgroundColor = .lightGray
    }
    private var barView = UIView().then{
        $0.backgroundColor = .lightGray
        $0.isUserInteractionEnabled = false
        $0.cornerRadius = 3
    }
    
    lazy var titleLabel = MainLabel(type: .Big1).then {
        $0.text = "교촌치킨 드실 분~"
        $0.textColor = .black
    }
//    private let storeName = UILabel().then {
//        $0.text = "삼첩분식 금정점"
//    }
//
//    var content : String
    lazy var dueTimeLabel = MainLabel(type: .Point4).then {
        $0.text = "• 마감 시간"
        $0.textColor = .gray3
    }
    lazy var dueTime = MainLabel(type: .Point4).then {
        $0.text = "04:00"
        $0.textColor = .gray3
    }
    lazy var AMPM = MainLabel(type: .Basics2).then {
        $0.text = "PM"
        $0.textColor = .unitGray
    }
    
    
    lazy var deliveryFeeLabel = MainLabel(type: .Point4).then {
        $0.text = "• 배달비"
        $0.textColor = .gray3
    }
    lazy var deliveryFee = MainLabel(type: .Point4).then {
        $0.text = "30,000"
        $0.textColor = .gray3
    }
    lazy var deliveryFeeUnitLabel = MainLabel(type: .Basics2).then {
        $0.text = "원"
        $0.textColor = .unitGray
    }
    
    lazy var deliveryAimMoneyLabel = MainLabel(type: .Point4).then {
        $0.text = "• 목표 주문 금액"
        $0.textColor = .gray3
    }
    lazy var deliveryAimMoney = MainLabel(type: .Big1).then {
        $0.text = "30,000"
        $0.textColor = .mainOrange1
    }
    lazy var aimUnitLabel = MainLabel(type: .Basics2).then {
        $0.text = "원"
        $0.textColor = .unitGray
    }
    
    
    lazy var presentOrderMoneyLabel = MainLabel(type: .Point4).then {
        $0.text = "• 현재 주문 금액"
        $0.textColor = .gray3
    }
    lazy var presentOrderMoney = MainLabel(type: .Big1).then {
        $0.text = "16,000"
        $0.textColor = .mainOrange1
    }
    lazy var presentUnitLabel = MainLabel(type: .Basics2).then {
        $0.text = "원"
        $0.textColor = .unitGray
    }
    
    private let progressBarBackground = UIView().then {
        $0.backgroundColor = .gray
        $0.cornerRadius = 8
    }
    
    private var progressBar = UIView().then {
        $0.backgroundColor = .mainOrange2
        $0.cornerRadius = 8
    }
    
    lazy var placeLabel = MainLabel(type: .Basics5).then {
        $0.text = "• 장소"
    }
    
    
  // MARK: Properties
  var mode: Mode = .tip {
    didSet {
      switch self.mode {
      case .tip:
        break
      case .full:
        break
      }
      self.updateConstraint(offset: Const.bottomSheetYPosition(self.mode))
    }
  }
    var bottomSheetColor: UIColor? {
        didSet { self.bottomSheetView.backgroundColor = self.bottomSheetColor }
    }
    var barViewColor: UIColor? {
        didSet { self.barView.backgroundColor = self.barViewColor }
    }
  
  // MARK: Initializer
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init() has not been implemented")
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.backgroundColor = .clear
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan))
    self.addGestureRecognizer(panGesture)
    
    self.bottomSheetView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    self.bottomSheetView.layer.cornerRadius = Const.cornerRadius
    self.bottomSheetView.clipsToBounds = true
    
    self.addSubview(self.bottomSheetView)
      
      self.bottomSheetView.addSubview(barView)
      self.bottomSheetView.addSubview(titleLabel)
      self.bottomSheetView.addSubview(dueTimeLabel)
      self.bottomSheetView.addSubview(dueTime)
      self.bottomSheetView.addSubview(AMPM)
      self.bottomSheetView.addSubview(deliveryFeeLabel)
      self.bottomSheetView.addSubview(deliveryFee)
      self.bottomSheetView.addSubview(deliveryFeeUnitLabel)
      self.bottomSheetView.addSubview(deliveryAimMoneyLabel)
      self.bottomSheetView.addSubview(deliveryAimMoney)
      self.bottomSheetView.addSubview(aimUnitLabel)
      self.bottomSheetView.addSubview(presentOrderMoneyLabel)
      self.bottomSheetView.addSubview(presentOrderMoney)
      self.bottomSheetView.addSubview(presentUnitLabel)
      self.bottomSheetView.addSubview(progressBarBackground)
      self.bottomSheetView.addSubview(progressBar)
      self.bottomSheetView.addSubview(placeLabel)
      
    self.bottomSheetView.snp.makeConstraints {
      $0.left.right.bottom.equalToSuperview()
      $0.top.equalTo(Const.bottomSheetYPosition(.tip))
    }
      
    self.barView.snp.makeConstraints {
        $0.centerX.equalToSuperview()
        $0.top.equalToSuperview().inset(Const.barViewTopSpacing)
        $0.size.equalTo(Const.barViewSize)
    }
      
    self.titleLabel.snp.makeConstraints { make in
        make.width.equalTo(171)
        make.height.equalTo(32)
        make.top.equalToSuperview().offset(30)
        make.leading.equalToSuperview().offset(25)
    }
      self.dueTimeLabel.snp.makeConstraints { make in
          make.width.equalTo(89)
          make.height.equalTo(23)
          make.top.equalToSuperview().offset(90)
          make.leading.equalToSuperview().offset(30)
      }
      
      self.dueTime.snp.makeConstraints { make in
          make.width.equalTo(54)
          make.height.equalTo(23)
          make.trailing.equalToSuperview().offset(-30)
          make.top.equalToSuperview().offset(90)
      }
      
      self.AMPM.snp.makeConstraints { make in
          make.width.equalTo(29)
          make.height.equalTo(21)
          make.trailing.equalToSuperview().offset(-7)
          make.top.equalToSuperview().offset(92)
      }
      
      self.deliveryFeeLabel.snp.makeConstraints { make in
          make.width.equalTo(60)
          make.height.equalTo(23)
          make.leading.equalTo(dueTimeLabel)
          make.top.equalTo(dueTimeLabel).offset(35)
      }
      
      self.deliveryFee.snp.makeConstraints { make in
          make.width.equalTo(63)
          make.height.equalTo(23)
          make.trailing.equalTo(dueTime)
          make.centerY.equalTo(deliveryFeeLabel)
      }
      
      self.deliveryFeeUnitLabel.snp.makeConstraints { make in
          make.width.equalTo(12)
          make.height.equalTo(21)
          make.trailing.equalToSuperview().offset(-18)
          make.centerY.equalTo(deliveryFee)
      }
      
      self.deliveryAimMoneyLabel.snp.makeConstraints { make in
          make.width.equalTo(107)
          make.height.equalTo(23)
          make.leading.equalTo(deliveryFeeLabel)
          make.top.equalTo(deliveryFeeLabel).offset(46)
      }
      
      self.deliveryAimMoney.snp.makeConstraints { make in
          make.width.equalTo(86)
          make.height.equalTo(32)
          make.trailing.equalTo(deliveryFee).offset(5)
          make.centerY.equalTo(deliveryAimMoneyLabel)
      }
      
      self.aimUnitLabel.snp.makeConstraints { make in
          make.width.equalTo(12)
          make.height.equalTo(21)
          make.trailing.equalTo(deliveryFeeUnitLabel)
          make.centerY.equalTo(deliveryAimMoney).offset(2)
      }
      
      self.presentOrderMoneyLabel.snp.makeConstraints { make in
          make.width.equalTo(deliveryAimMoneyLabel)
          make.height.equalTo(deliveryAimMoneyLabel)
          make.trailing.equalTo(deliveryAimMoneyLabel)
          make.top.equalTo(deliveryAimMoneyLabel).offset(37)
      }
      
      self.presentOrderMoney.snp.makeConstraints { make in
          make.width.equalTo(deliveryAimMoney)
          make.height.equalTo(deliveryAimMoney)
          make.leading.equalTo(deliveryAimMoney)
          make.centerY.equalTo(presentOrderMoneyLabel)
      }
      
      self.presentUnitLabel.snp.makeConstraints { make in
          make.width.equalTo(aimUnitLabel)
          make.height.equalTo(aimUnitLabel)
          make.trailing.equalTo(aimUnitLabel)
          make.centerY.equalTo(presentOrderMoney).offset(2)
      }
      
      self.progressBarBackground.snp.makeConstraints { make in
          make.width.equalTo(320)
          make.height.equalTo(16)
          make.centerX.equalToSuperview()
          make.top.equalTo(presentOrderMoneyLabel).offset(40)
      }
      
      self.progressBar.snp.makeConstraints { make in
          make.width.equalTo(150)
          make.height.equalTo(16)
          make.leading.equalTo(progressBarBackground)
          make.top.equalTo(progressBarBackground)
      }
      self.placeLabel.snp.makeConstraints { make in
          make.width.equalTo(40)
          make.height.equalTo(23)
          make.leading.equalTo(presentOrderMoneyLabel)
          make.top.equalTo(presentOrderMoneyLabel).offset(71)
      }
  }
  
  // MARK: Methods
  @objc private func didPan(_ recognizer: UIPanGestureRecognizer) {
    let translationY = recognizer.translation(in: self).y
    let minY = self.bottomSheetView.frame.minY
    let offset = translationY + minY
    
    if Const.bottomSheetYPosition(.full)...Const.bottomSheetYPosition(.tip) ~= offset {
      self.updateConstraint(offset: offset)
      recognizer.setTranslation(.zero, in: self)
    }
    UIView.animate(
      withDuration: 0,
      delay: 0,
      options: .curveEaseOut,
      animations: self.layoutIfNeeded,
      completion: nil
    )
    
    guard recognizer.state == .ended else { return }
    UIView.animate(
      withDuration: Const.duration,
      delay: 0,
      options: .allowUserInteraction,
      animations: {
        // velocity를 이용하여 위로 스와이프인지, 아래로 스와이프인지 확인
        self.mode = recognizer.velocity(in: self).y >= 0 ? Mode.tip : .full
      },
      completion: nil
    )
  }
  
  private func updateConstraint(offset: Double) {
    self.bottomSheetView.snp.remakeConstraints {
      $0.left.right.bottom.equalToSuperview()
      $0.top.equalToSuperview().inset(offset)
    }
  }
}
