//
//  UIImageView.swift
//  DIVIDE
//
//  Created by 정지윤 on 2022/07/04.
//

import UIKit
import Photos

extension UIImageView {
    func fetchImage(asset: PHAsset, contentMode: PHImageContentMode, targetSize: CGSize) {
        let options = PHImageRequestOptions()
        options.version = .original
        PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: contentMode, options: options) { image, _ in
            if let image = image {
                self.image = image
                self.clipsToBounds = true
                if contentMode == .aspectFill {
                    self.contentMode = .scaleAspectFill
                } else if contentMode == .aspectFit {
                    self.contentMode = .scaleAspectFit
                }
            }
        }
    }
}
