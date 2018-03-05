//
//  AppDelegate.swift
//  3DTouch
//
//  Created by Duy Tran N. on 1/5/18.
//  Copyright © 2018 Asiantech. All rights reserved.
//

import UIKit
import ContactsUI.UIApplicationShortcutIcon_Contacts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    enum ShortcutIdentifier: String {
        case navigateToUserPreview
        case navigateToUserDetail
        case navigateToListUser
        case myStaticAction

        // TODO: - Hàm init này để làm gì ?
        init?(fullIdentifier: String) {
            guard let shortIdentifier = fullIdentifier.components(separatedBy: ".").last else {
                return nil
            }
            self.init(rawValue: shortIdentifier)
        }

        // Tạo type cho quick action với format: `bundleIdentifier + "." + rawValue` của enum.
        // 1 Project có thể có nhiều target, nên HSQA cần phải có 1 identifier riêng biệt, nên sẽ sử dụng bundleIdentifier của mỗi ứng dụng.
        // Cả 2 dạng Static và Dynamic cần phải đặt tên theo chung 1 format để dễ xử lý hành động về sau.
        // Ví dụ:
            // bundleIndentifier: asiantech.-DTouch
            // rawValue: navigateToUserDetail
            // type sẽ là: asiantech.-DTouch.navigateToUserDetail
        var type: String {
            return Bundle.main.bundleIdentifier! + ".\(self.rawValue)"
        }
    }

    // MARK: Properties
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        if let window = window {
//            let listUserViewController = TestShadowViewController()
            let listUserViewController = ListUserViewController()
            let rootNaviController = UINavigationController(rootViewController: listUserViewController)
            window.makeKeyAndVisible()
            window.backgroundColor = .white
            window.rootViewController = rootNaviController
        }

        // Khởi tạo các item của Home Screen Quick Actions (Loại Dynamic)
        let quickActionItem1 = UIApplicationShortcutItem(type: ShortcutIdentifier.navigateToUserPreview.type,
                                                         localizedTitle: "User Preview",
                                                         localizedSubtitle: "Subtitle of User Preview",
                                                         icon: UIApplicationShortcutIcon(templateImageName: "ic_dynamicCustom1"),
                                                         userInfo: nil)

        let quickActionItem2 = UIApplicationShortcutItem(type: ShortcutIdentifier.navigateToUserDetail.type,
                                                         localizedTitle: "User Detail",
                                                         localizedSubtitle: "Subtitle of User Detail",
                                                         icon: UIApplicationShortcutIcon(templateImageName: "ic_dynamicCustom2"),
                                                         userInfo: nil)

        let quickActionItem3 = UIApplicationShortcutItem(type: ShortcutIdentifier.navigateToListUser.type,
                                                         localizedTitle: "List User",
                                                         localizedSubtitle: "Subtitle of List User",
                                                         icon: UIApplicationShortcutIcon(templateImageName: "ic_dynamicCustom3"),
                                                         userInfo: nil)

        // Gom các item Home Screen Quick Actions vào cùng array và gán nó cho thuộc tính shortcutItems của application
        application.shortcutItems = [quickActionItem1, quickActionItem2, quickActionItem3]

        // TODO: - Test feature of this variable and `if let`
        var performAdditionalHandling = true

        if let _ = launchOptions?[UIApplicationLaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            performAdditionalHandling = false
        }

        return performAdditionalHandling
    }

    // Sẽ chạy đến hàm này khi có một Home Screen Quick Actions bất kỳ được ấn chọn
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        let handledShortCutItem = handleShortCutItem(shortcutItem)
        completionHandler(handledShortCutItem)
    }

    func handleShortCutItem(_ shortcutItem: UIApplicationShortcutItem) -> Bool {
        var handled = false
        var vc: UIViewController = ListUserViewController()

        // Kiểm tra thuộc tính type của đối tượng shortcutItem, nếu không nil thì sẽ được pass và xử lý tiếp các đoạn mã ở dưới
        guard ShortcutIdentifier(fullIdentifier: shortcutItem.type) != nil else { return false }
        guard let shortCutType = shortcutItem.type as String? else { return false }
        // Kiểm tra giá trị shortcutType

        switch shortCutType {
        // Nơi xử lý các hành động của Home Screen Quick Actions bao gồm cả 2 dạng `static` và `dynamic`
        case ShortcutIdentifier.navigateToUserPreview.type:
            vc = PreviewUserViewController()
            handled = true
            break
        case ShortcutIdentifier.navigateToUserDetail.type:
            vc = DetailUserViewController()
            handled = true
            break
        case ShortcutIdentifier.navigateToListUser.type:
            vc = ListUserViewController()
            handled = true
            break
        case ShortcutIdentifier.myStaticAction.type:
            // Xử lý hành động dành cho Static Action
            vc = ListUserViewController()
            handled = true
            break
        default:
            break
        }

        // Các đoạn code xử lý hành động cho Home Screen Quick Actions
        let alertController = UIAlertController(title: Strings.shortcutHandled, message: shortCutType, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Strings.ok, style: .default, handler: nil)
        let navi = UINavigationController(rootViewController: vc)

        alertController.addAction(okAction)
        window?.rootViewController?.present(alertController, animated: true, completion: nil)
        window?.rootViewController = navi
        return handled
    }
}
