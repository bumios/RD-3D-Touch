//
//  FirstWidgetViewController.swift
//  FirstWidget
//
//  Created by Duy Tran N. on 2/8/18.
//  Copyright © 2018 Asiantech. All rights reserved.
//

import UIKit
import NotificationCenter

@objc(FirstWidgetViewController)                        // Mặc định widget sẽ dùng storyboard, nếu muốn sử dụng xib thì phải có dòng này

final class FirstWidgetViewController: UIViewController {

    struct Config {
        static let customWidgetHeight: CGFloat = 220
        static let defaultWidgetHeight: CGFloat = 110
    }

    // MARK: - Outlets
    @IBOutlet fileprivate weak var firstAvatarImageView: UIImageView!
    @IBOutlet fileprivate weak var secondAvatarImageView: UIImageView!
    @IBOutlet fileprivate weak var thirdAvatarImageView: UIImageView!
    @IBOutlet fileprivate weak var fourthAvatarImageView: UIImageView!
    @IBOutlet fileprivate weak var fifthAvatarImageView: UIImageView!
    @IBOutlet fileprivate weak var sixthAvatarImageView: UIImageView!
    @IBOutlet fileprivate weak var firstNameLabel: UILabel!
    @IBOutlet fileprivate weak var secondNameLabel: UILabel!
    @IBOutlet fileprivate weak var thirdNameLabel: UILabel!
    @IBOutlet fileprivate weak var fourthNameLabel: UILabel!
    @IBOutlet fileprivate weak var fifthNameLabel: UILabel!
    @IBOutlet fileprivate weak var sixthNameLabel: UILabel!
    @IBOutlet fileprivate weak var topLaneView: UIView!
    @IBOutlet fileprivate weak var botLaneView: UIView!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }

    // MARK: - IBActions
    @IBAction func backgroundButtonTouchUpInside(_ sender: Any) {
        let appString = Strings.appURLSchemes + "://"
        openUrl(urlString: appString)
    }
}

extension FirstWidgetViewController: NCWidgetProviding {
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        let widgetExpanded = activeDisplayMode == .expanded                     // Kiểm tra trạng thái hiển thị của widget
        botLaneView.isHidden = !widgetExpanded

        if widgetExpanded {
            preferredContentSize = CGSize(width: maxSize.width, height: Config.customWidgetHeight)
        } else {
            preferredContentSize = CGSize(width: maxSize.width, height: Config.defaultWidgetHeight)
        }
    }

    func widgetPerformUpdate(completionHandler: @escaping (NCUpdateResult) -> Void) {
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded         // Đặt trạng thái hiển thị của widget là có thể mở rộng ra
        completionHandler(.newData)                                             // [?] Chưa thấy tác dụng của hàm này
    }
}

extension FirstWidgetViewController {
    private func configUI() {
        // Create border for each image view
        let arrayImageView: [UIImageView] = [firstAvatarImageView, secondAvatarImageView, thirdAvatarImageView,
                                              fourthAvatarImageView, fifthAvatarImageView, sixthAvatarImageView]

        for imageView in arrayImageView {
            imageView.configBorderWith(cornerRadius: 30, width: 2, color: .white)
        }

        // Create bottom border for bot lane view
        let borderLayer = CALayer()
        let borderLayerWidth = botLaneView.frame.size.width / 3
        let borderLayerX = (botLaneView.frame.size.width - borderLayerWidth) / 2

        borderLayer.backgroundColor = UIColor.white.cgColor
        borderLayer.frame = CGRect(x: borderLayerX, y: 0, width: borderLayerWidth, height: 1)
        botLaneView.layer.addSublayer(borderLayer)
    }

    func openUrl(urlString: String) {
        guard let convertedUrl = URL(string: urlString) else { return }
        extensionContext?.open(convertedUrl, completionHandler: nil)
    }
}
