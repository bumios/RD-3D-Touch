//
//  UIViewExt.swift
//  3DTouch
//
//  Created by Duy Tran N. on 2/22/18.
//  Copyright © 2018 Asiantech. All rights reserved.
//

import UIKit

extension UIView {
    func configBorderWith(cornerRadius: CGFloat, width: CGFloat, color: UIColor) {
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = cornerRadius
    }

    func configTransparentViewWith(alpha: CGFloat = 0.5, color: UIColor) {
        let transparentView = UIView()
        let widthRatio = UIScreen.main.bounds.width / 375
        let heightRatio = UIScreen.main.bounds.height / 667
        if let imageViewLayers = self.layer.sublayers {
            for layer in imageViewLayers {
                layer.removeFromSuperlayer()
            }
        }

        transparentView.frame = self.bounds
        transparentView.frame.size.width = self.bounds.height * widthRatio
        transparentView.frame.size.height = self.bounds.height * heightRatio
        transparentView.backgroundColor = color
        transparentView.alpha = alpha
        self.layer.masksToBounds = true
        self.layer.addSublayer(transparentView.layer)
    }
}
