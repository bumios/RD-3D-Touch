//
//  UIImageViewExt.swift
//  3DTouch
//
//  Created by Duy Tran N. on 2/9/18.
//  Copyright © 2018 Asiantech. All rights reserved.
//

import UIKit

extension UIImageView {
    func configImageWithBlur(image: UIImage, alpha: CGFloat = 0.5) {
        let effect = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: effect)

        effectView.alpha = alpha
        effectView.frame = self.bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.image = image
        self.addSubview(effectView)
    }
}
