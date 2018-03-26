//
//  PreviewUserViewController.swift
//  3DTouch
//
//  Created by Duy Tran N. on 1/5/18.
//  Copyright © 2018 Asiantech. All rights reserved.
//

import UIKit

final class PreviewUserViewController: UIViewController {

    struct Config {
        static let backgroundAlpha: CGFloat = 0.7
        static let avatarBorderWidth: CGFloat = 2
    }

    // MARK: - Outlets
    @IBOutlet fileprivate weak var ageLabel: UILabel!
    @IBOutlet fileprivate weak var usernameLabel: UILabel!
    @IBOutlet fileprivate weak var positionLabel: UILabel!
    @IBOutlet fileprivate weak var avatarImageView: UIImageView!
    @IBOutlet fileprivate weak var backgroundImageView: UIImageView!

    // MARK: - Properties
    var viewModel: PreviewUserViewModel? {
        didSet {
            updateView()
        }
    }

    // Preview Action Items for PEEK
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

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }

    // MARK: - IBActions
    @IBAction func showUserDetailButtonTouchUpInside(_ sender: Any) {
        guard let viewModel = viewModel else { return }
        let userDetailVC = DetailUserViewController()
        userDetailVC.viewModel = viewModel.viewModelForUserDetail()
        navigationController?.pushViewController(userDetailVC, animated: true)
    }
}

extension PreviewUserViewController {
    // MARK: - Private
    private func configUI() {
        title = "Preview"
        let ratio = UIScreen.main.bounds.width / 375
        let avatarImageCorner = (avatarImageView.bounds.size.width * ratio) / 2

        backgroundImageView.configTransparentViewWith(alpha: Config.backgroundAlpha, color: .black)
        avatarImageView.configBorderWith(cornerRadius: avatarImageCorner, width: Config.avatarBorderWidth, color: .white)
    }

    private func updateView() {
        guard let viewModel = viewModel, let user = viewModel.user else { return }
        usernameLabel.text = user.userName
        ageLabel.text = String(format: Strings.ageFormatString, user.age)
        positionLabel.text = String(format: Strings.positionFormatString, user.position)
        avatarImageView.image = UIImage(named: user.imageName)
        backgroundImageView.image = UIImage(named: user.backgroundImageName)
    }
}
