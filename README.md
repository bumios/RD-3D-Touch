![3D Touch](https://9to5mac.files.wordpress.com/2016/05/screen-shot-2015-09-26-at-5-44-22-pm.png?w=1600&h=1000)

# 3D TOUCH
Tính năng 3D Touch được phát triển bởi Apple, dựa vào **Hệ thống cảm ứng lực nhấn**. Các thiết bị từ **iPhone 6s** trở về sau đều được cung cấp bộ phận này. Điều mà người sử dụng cần chú ý ở đây đó là việc người đó sẽ ấn vào màn hình với lực ấn như thế nào, chúng ta sẽ tìm hiểu tính năng này theo từng mục dưới đây.


## Nội dung bài viết
- [Yêu cầu tối  thiểu (Prerequisites)](#prerequisites)
- [Tổng quan về 3D Touch (Overview 3D TOUCH)](#overview-3d-touch)
- [Các hành động nhanh tại màn hình chính (Home Screen Quick Actions)](#home-screen-quick-actions)
- [Nhấn giữ và nhấn mạnh (Peek and Pop)](#peek-and-pop)
- [PreviewActionItems](#previewactionitems)
- [UIPreviewInteraction](#uipreviewinteraction)
- [Công cụ & tài liệu (Useful Tools and Resources)](#useful-tools-and-resources)




## Prerequisites

- Phiên bản của thiết bị: [iPhone 6s](https://www.apple.com/iphone-6s/specs/) trở lên.
- Phiên bản hệ điều hành iOS: [9.0](https://developer.apple.com/library/content/releasenotes/General/WhatsNewIniOS/Articles/iOS9.html) trở lên.
- Phiên bản Xcode: Bắt đầu từ phiên bản [7.1](https://developer.apple.com/library/content/documentation/Xcode/Conceptual/WhatsNewXcode-Archive/Articles/xcode_7_0.html) (Simulator chưa hỗ trợ test tại phiên bản Xcode 7.1 này).




## Overview 3D TOUCH

Bắt đầu từ phiên bản **iPhone 6s** trở đi - Apple cung cấp thêm hệ thống nhận diện lực cho màn hình cảm ứng, một phần chính hỗ trợ chủ đạo cho tính năng 3D Touch. Tại màn hình chính, người dùng có thể sử dụng được các chức năng chính bằng cách ấn mạnh vào ứng dụng. Còn khi đang ở bên trong ứng dụng người dùng có thể xem nhanh qua thông tin của một đối tượng bất kỳ hoặc cũng có thể xem chi tiết mà không cần phải đi theo luồng chính của ứng dụng, tính năng này sẽ được mô tả và đi sâu hơn tại phần [Nhấn giữ và nhấn mạnh (Peek and Pop)](#peek-and-pop).
##### Hệ thống trợ lực cho cảm biến:

![iPhone6S](http://1.bp.blogspot.com/-k4Jpnt1un8I/VfCL7Q2mMfI/AAAAAAAAEgk/m4TzgpHXrtA/s1600/iphone_sensor_s_animation.0.gif)

Để xem & thay đổi trạng thái của tính năng này tại thiết bị, làm theo các bước sau:
> Settings / General / Accessibility / 3D Touch.



## Home Screen Quick Actions

> Lưu ý: `Home Screen Quick Actions` sẽ được gọi rất nhiều lần trong bài viết, nên mình sẽ đặt từ khoá là **HSQA** cho ngắn gọn.
>
#### Cách sử dụng:
HSQA là hành động khi mà người dùng đang ở tại **màn hình chính** và  **nhấn mạnh** vào một ứng dụng, ngay sau đó sẽ có một danh sách hiển thị các hành động chính nằm ngay bên cạnh ứng dụng.

#### Thông tin cơ bản về HSQA:
* HSQA có **hai** loại chính, đó là:
  * Dạng tĩnh **(Static)**
  * Dạng động **(Dynamic)**
* Tổng cộng các item mà HSQA có thể có là **4**. (Là tổng của 2 dạng tĩnh và động cộng lại).

Điểm khác nhau giữa mỗi loại sẽ được sơ lược qua bảng đồ dưới đây:

| Sự khác nhau     | Dạng tĩnh (Static)                                  | Dạng động (Dynamic)                                          |
| ---------------- | --------------------------------------------------- | ------------------------------------------------------------ |
| Khởi tạo         | Ngay sau khi **cài đặt** ứng dụng                   | Sau **lần đầu chạy** ứng dụng                                |
| Tuỳ biến         | Chỉ có thể thiết lập tại file `info.plist`          | Toàn bộ sẽ được thiết lập bằng code                          |
| Icon             | Chỉ sử dụng được các icon cung cấp sẵn của hệ thống | Icon của hệ thống, Icon custom, Andress Book Contact (`CNContact`) |
| Thứ tự xuất hiện | Được **xếp trước** dạng Dynamic                     | Luôn luôn được **xếp sau** dạng Static                       |

#### Cách thức khởi tạo HSQA:
##### Cách tạo HSQA dạng tĩnh (Tại file `Info.plist`):
![CreateStaticQuickAction](https://i.imgur.com/pdIWDFe.png)

##### Cách tạo HSQA dạng động (Tại file `AppDelegate.swift`):
```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
	let actionType = "atios.-3DTouch.sendMessage"
	let actionTitle = "Send message"
	let actionSubtitle = "Send a message to your friend"
	let actionIcon = UIApplicationShortcutIcon(templateImageName: "ic_dynamicCustom")
	// Tạo thêm các HSQA Item khác tại đây
	let quickActionItem = UIApplicationShortcutItem(type: actionType, localizedTitle: actionTitle, localizedSubtitle: actionSubtitle, icon: actionIcon, userInfo: nil)
	
	// Gom các item được tạo vào trong 1 mảng, và gán cho thuộc tính của hệ thống
	let quickActionItems = [quickActionItem]
	application.shortcutItems = quickActionItems
}
```

##### Xử lý hành động của HSQA: (Tại file`AppDelegate.swift`)
```swift
// Hàm sẽ được chạy khi có bất kỳ HSQA nào được chọn
func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
	let handledShortCutItem = handleShortCutItem(shortcutItem)
	completionHandler(handledShortCutItem)
}

func handleShortCutItem(_ shortcutItem: UIApplicationShortcutItem) -> Bool {
	var handled = false

	// Switch đến shortItem.type (là thuộc tính `ShortcutItemType` được tạo ở phía trên) để phân biệt các hành động
	guard ShortcutIdentifier(fullIdentifier: shortcutItem.type) != nil else { return false }
	guard let shortCutType = shortcutItem.type as String? else { return false }

	switch shortCutType {
	case "atios.-3DTouch.sendMessage"
		print("Send message has been touched")
		handled = true
		break
	default:
		break
	}

	// Tại đây có thể tuỳ ý xử lý các đọan mã chuyển root, present, hiển thị alert ...
	return handled
}
```

#### [!] Lưu ý khi làm `HSQA`:
* Tiêu đề (Title) & phụ đề (Subtitle) phải ngắn gọn và rõ ràng (Số ký tự được đếm tại tiêu đề là **14** ký tự, và phụ đề là **18** ký tự).

* Tổng số lượng mà HSQA được hỗ trợ là **4** action, bắt đầu tính từ static rồi mới đến dynamic, chỉ dừng lại ở 4 cái đầu tiên trong danh sách, những action được tạo ở sau sẽ không được hiển thị lên.

* Chỉ chọn ra những tính năng thật sự cần thiết & không phát sinh thêm bất kỳ bước nào trong quá trình thực hiện hành động.
   Kích cỡ chuẩn khi thiết kế Icon:	
   * 70px * 70px cho ảnh dạng @2x.
   * 104px * 104px cho ảnh dạng @3x.

* Không thể sử dụng các icon có màu sắc để làm icon, vì icon của HSQA thuộc loại **màu đơn sắc (monochromatic)**.


**Demo**

![HSQA-gif](https://media.giphy.com/media/gC1iv200g7G89mR20w/giphy.gif)



## Peek and Pop

Điều đầu tiên, mình xin phép nhắc lại mọi người trước khi đi qua phần mới `Peek and Pop`. Mọi người cần hiểu và phân biệt 2 vấn đề ở dưới đây:
- **Home Screen Quick Actions** là hành động khi người dùng ấn mạnh vào ứng dụng khi đang ở tại **màn hình chính**.
- **Peek & Pop** là hành động người dùng ấn mạnh vào một thành phần giao diện nằm ở **bên trong ứng dụng**.

#### Sự khác nhau giữa Peek & Pop:
* Khi người dùng ấn mạnh vào một thành phần giao diện bất kỳ, một `View Controller` khác sẽ xuất hiện với các thông tin cơ bản của một đối tượng, toàn bộ quá trình trên được gọi là **Peek**.
* Vẫn giữ nguyên lực tay trong trạng thái Peek, người dùng tiếp tục ấn mạnh thêm một lần nữa vào màn hình cảm ứng, lại tiếp tục có 1 `View Controller` khác xuất hiện với toàn bộ thông tin chi tiết về đối tượng đó, thì được gọi là **Pop**.

*2 điều được giải thích ở trên chính là mục đích chính của peek và pop, peek sẽ hiển thị các thông tin cơ bản của 1 đối tượng, có thể hiểu đối tượng ở đây là 1 bài viết, hoặc 1 sản phẩm nào đó ... Còn Pop sẽ hiển thị các thông tin chi tiết của đối tượng đó. Có thể nói là muốn có Pop thì trước đó phải qua giai đoạn Peek. Không nhất thiết có Peek là phải có Pop, nhưng để tối ưu hoá về phần UX thì ứng dụng nên hỗ trợ cả 2.*

#### Các bước thực hiện:
##### Cây thư mục của quá trình thực hiện:
| Tên file                     | Khái niệm                                               | Nhiệm vụ                                                     |
| ---------------------------- | ------------------------------------------------------- | ------------------------------------------------------------ |
| ListUserViewController.swift | Hiển thị list danh sách các User theo dạng `Table View` | Gán phần tử `Table View` với nhiệm vụ `Preview View (peek)`, nhận & xử lý thông tin khi người dùng ấn mạnh vào Table View. Xử lý các hành động của Peek `Preview View` và Pop `Commit View` |
| ListUserTableCell            | Hiển thị thông tin của mỗi cell                         | Cập nhật dữ liệu                                             |
| PreviewUserViewController    | Hiển thị thông tin cơ bản của người dùng                | Khởi tạo và xử lý các hành động (`previewActionItems`) được hỗ trợ dành riêng cho `Preview View (peek)`. |
| DetailUserViewController     | Hiển thị thông tin chi tiết của người dùng              | Cập nhật dữ liệu chi tiết                                    |

##### Tại file `ListUserViewController`
##### Đăng ký preview cho phần tử trên giao diện: 
```swift
override func viewDidLoad() {
	super.viewDidLoad()
	// Kiểm tra trạng thái của tính năng 3DTouch trong thiết bị
	if traitCollection.forceTouchCapability == .available {
		// Đăng ký tính năng PEEK cho phần tử UI `tableView`
		registerForPreviewing(with: self, sourceView: tableView)
	} else {
		alertController = UIAlertController(title: "Error", message: "This device do not support 3D Touch", preferredStyle: .alert)
	}
}
```

##### Thêm & xử lý protocol UIViewControllerPreviewingDelegate:
```swift
extension ListUserViewController: UIViewControllerPreviewingDelegate {
    // PEEK
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        // Xác định indexPath row của tableView
        guard let indexPath = tableView.indexPathForRow(at: location) else { return nil }
        let previewUserViewController = PreviewUserViewController()
        let cellRect = tableView.rectForRow(at: indexPath)
        let sourceRect = previewingContext.sourceView.convert(cellRect, from: tableView)
        previewUserViewController.preferredContentSize = CGSize(width: 0, height: 300)

        previewUserViewController.viewModel = viewModel.viewModelForUserPreview(at: indexPath)
        previewingContext.sourceRect = sourceRect
        // Tạo 1 biến rowIndexPath để lưu lại giá trị, sẽ được ở dụng ở hàm dưới
        rowIndexPath = indexPath
        return previewUserViewController
    }

    // POP
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        // Load dữ liệu tương ứng cho POP View & hiển thị
        let userDetailViewController = DetailUserViewController()
        // Lấy ra giá trị rowIndexPath được lưu ở trên để load dữ liệu tương ứng cho Pop Screen
        userDetailViewController.viewModel = viewModel.viewModelForUserDetail(at: rowIndexPath)
        show(userDetailViewController, sender: self)
    }
}
```
#### [!] Lưu ý khi làm `Peek & Pop`:
* Layout của Peek sẽ được chỉnh sửa tại trang đăng ký cho nó, không phụ thuộc vào class chứa nó. (`PreviewUserViewController` là màn hình peek, nhưng mà `ListUserViewController` mới chính là nơi xử lý contentSize của màn hình peek).


**Demo**

![](https://media.giphy.com/media/1AgUM57x8qU9NyFrA2/giphy.gif)



## PreviewActionItems

Là một danh sách các lựa chọn được sắp xếp theo kiểu Action Sheet, 3DTouch hỗ trợ cả `UIPreviewAction` và `UIPreviewActionGroup`.
Điểm mạnh của previewActionItems là không giới hạn số lượng action/actionGroup mà nó có thể chứa.

##### Tại file `PreviewUserViewController` thêm đoạn mã bên dưới để khởi tạo previewActionItems
```swift
final class PreviewUserViewController: UIViewController {
	override var previewActionItems: [UIPreviewActionItem] {
        // Preview Action
        let action1 = UIPreviewAction(title: "Default Action", style: .default) { (_, _) in
            print("-> Default Action")
        }
        let action2 = UIPreviewAction(title: "Selected Action", style: .selected) { (_, _) in
            print("-> Selected Action")
        }
        let action3 = UIPreviewAction(title: "Destructive Action", style: .destructive) { (_, _) in
            print("-> Destructive Action")
        }

        // Preview Action Group
        let emojiAction1 = UIPreviewAction(title: "😀", style: .default) { (_, _) in
            print("-> Smile face")
        }
        let emojiAction2 = UIPreviewAction(title: "😎", style: .default) { (_, _) in
            print("-> Cool face")
        }
        let emojiAction3 = UIPreviewAction(title: "😇", style: .default) { (_, _) in
            print("-> Angel face")
        }
        let emojiAction4 = UIPreviewAction(title: "😥", style: .default) { (_, _) in
            print("-> Cry face")
        }
        let emojiAction5 = UIPreviewAction(title: "😈", style: .default) { (_, _) in
            print("-> Devil face")
        }
        let emojiAction6 = UIPreviewAction(title: "😍", style: .default) { (_, _) in
            print("-> Love face")
        }
        let actionGroup = UIPreviewActionGroup(title: "Emoji Action (Group)", style: .default, actions: [emojiAction1, emojiAction2, emojiAction3, emojiAction4, emojiAction5, emojiAction6])
        
        return [action1, action2, action3, actionGroup]
    }
}
```

**Demo**

![](https://media.giphy.com/media/82J3lFOppbTbBETkJu/giphy.gif)



## UIPreviewInteraction

#### Tổng quan về UIPreviewInteraction
UIPreviewInteraction là các hàm được dựng sẵn hỗ trợ phát hiện trạng thái hiện tại của người dùng khi đang tác động đến tính năng của 3DTouch.
##### Cách thực hiện:
###### Tại file `ListUserViewController`:
```swift
final class ListUserViewController: UIViewController {
	private var previewInteraction: UIPreviewInteraction!

	override func viewDidLoad() {
		super.viewDidLoad()

		previewInteraction = UIPreviewInteraction(view: view)
		previewInteraction.delegate = self
	}
}

// MARK: - UIPreviewInteractionDelegate
extension ListUserViewController: UIPreviewInteractionDelegate {
    func previewInteraction(_ previewInteraction: UIPreviewInteraction, didUpdatePreviewTransition transitionProgress: CGFloat, ended: Bool) {
		// transitionProgress:
			// trạng thái ấn của người dùng, nó sẽ chạy liên tục.
			// lực ấn càng cao, số càng lớn.
		// ended:
			// trạng thái khi kết thúc quá trình, true = kết thúc và ngược lại.

        if ended {
            // Khi người dùng đã hoàn tất trạng thái Peek
        }
    }

    func previewInteraction(_ previewInteraction: UIPreviewInteraction, didUpdateCommitTransition transitionProgress: CGFloat, ended: Bool) {
	    // Khái niệm transitionProgress tương tự như hàm ở trên
        if ended {
			// Khi người dùng đã hoàn tất trạng thái Pop
        }
    }

    func previewInteractionDidCancel(_ previewInteraction: UIPreviewInteraction) {
        // Hàm này được chạy khi:
	        // Đang ở trong trạng thái peek mà thả ngón tay ra không vào pop
	        // Đang trong trạng thái peek và vuốt lên trên để dùng Preview Action
    }

    func previewInteractionShouldBegin(_ previewInteraction: UIPreviewInteraction) -> Bool {
        // Hàm này được chạy khi:
	        // Người dùng bắt đầu ấn mạnh vào phần tử UI được registerPreviewing
        return true
    }
}
```



## Useful Tools and Resources

* [Swimat](https://github.com/Jintin/Swimat) - Phần mềm hỗ trợ căn chỉnh các đoạn mã trong Xcode.
* [Ray Wenderlich](https://www.raywenderlich.com/) - Nơi cung cấp các bài viết hướng dẫn rất bổ ích trong việc hoàn thiện ứng dụng.
* Apple Document: [Các thông tin cơ bản về 3D Touch](https://developer.apple.com/ios/3d-touch/), [Thiết kế giao diện cho người dùng](https://developer.apple.com/ios/human-interface-guidelines/user-interaction/3d-touch/) và [các thông tin thêm về tính năng](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/Adopting3DTouchOniPhone/).
* Video: [A Peek of 3D Touch](https://developer.apple.com/videos/play/wwdc2016/228/).