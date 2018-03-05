//
//  ListUserTableCell.swift
//  3DTouch
//
//  Created by Duy Tran N. on 1/8/18.
//  Copyright © 2018 Asiantech. All rights reserved.
//

import UIKit

class ListUserTableCell: UITableViewCell {

    struct Config {
        static let avatarImageCorner: CGFloat = 40/2
        static let avatarBorderWidth: CGFloat = 2
        static let rowHeight: CGFloat = 200
        static let cornerRadius: CGFloat = 5
        static let shadowRadius: CGFloat = 5
    }

    // MARK: - Outlets
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var positionLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!
    
    // MARK: - Properties
    var viewModel: ListUserTableCellViewModel? {
        didSet {
            updateCell()
        }
    }

    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()

        configUI()
    }
}

// MARK: - Extension ListUserTableCell
extension ListUserTableCell {
    // MARK: - Private
    private func updateCell() {
        guard let viewModel = viewModel, let user = viewModel.user else { return }
        userNameLabel.text = user.userName
        positionLabel.text = user.position
        avatarImageView.image = UIImage(named: user.imageName)
        backgroundImageView.image = UIImage(named: user.backgroundImageName)
    }

    private func configUI() {
        avatarImageView.configBorderWith(cornerRadius: Config.avatarImageCorner, width: Config.avatarBorderWidth, color: .white)
        backgroundImageView.layer.cornerRadius = Config.cornerRadius
    }
}
