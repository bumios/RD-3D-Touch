//
//  DetailUserViewController.swift
//  3DTouch
//
//  Created by Duy Tran N. on 1/5/18.
//  Copyright © 2018 Asiantech. All rights reserved.
//

import UIKit

final class DetailUserViewController: UIViewController {

    struct Config {
        static let avatarBorderWidth: CGFloat = 2
        static let avatarImageCorner: CGFloat = 40
    }

    // MARK: - Outlets
    @IBOutlet fileprivate weak var ageLabel: UILabel!
    @IBOutlet fileprivate weak var usernameLabel: UILabel!
    @IBOutlet fileprivate weak var positionLabel: UILabel!
    @IBOutlet fileprivate weak var descriptionLabel: UILabel!
    @IBOutlet fileprivate weak var avatarImageView: UIImageView!
    @IBOutlet fileprivate weak var backgroundImageView: UIImageView!
    
    // MARK: - Properties
    var viewModel: DetailUserViewModel? {
        didSet {
            updateView()
        }
    }

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        view.backgroundColor = .white
    }
}

extension DetailUserViewController {
    // MARK: - Private
    private func configUI() {
        title = "Detail"
        backgroundImageView.configTransparentViewWith(color: .black)
        avatarImageView.configBorderWith(cornerRadius: Config.avatarImageCorner, width: Config.avatarBorderWidth, color: .white)
    }

    private func updateView() {
        guard let viewModel = viewModel, let user = viewModel.user else { return }

        if let backgroundImage = UIImage(named: user.backgroundImageName) {
            backgroundImageView.configImageWithBlur(image: backgroundImage, alpha: 0.7)
        }

        usernameLabel.text = user.userName
        descriptionLabel.text = user.description
        ageLabel.text = String(format: Strings.ageFormatString, user.age)
        positionLabel.text = String(format: Strings.positionFormatString, user.position)
        avatarImageView.image = UIImage(named: user.imageName)
    }
}
