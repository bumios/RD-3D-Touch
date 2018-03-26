//
//  ListUserViewController.swift
//  3DTouch
//
//  Created by Duy Tran N. on 1/5/18.
//  Copyright © 2018 Asiantech. All rights reserved.
//

import UIKit
import MVVM

final class ListUserViewController: UIViewController {

    struct Config {
        static let rowHeight: CGFloat = 200
        static let cellSpacingHeight: CGFloat = 15
        static let cellCornerRadius: CGFloat = 4
    }

    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties
    lazy var rowIndexPath = IndexPath()             // rowIndexPath được thiết lập sau mỗi lần ấn PEEK để POP có thể sử dụng lại cho việc load dữ liệu
    private var viewModel = ListUserViewModel()
    private var alertController: UIAlertController?
    private var previewInteraction: UIPreviewInteraction!
    let previewUserViewController = PreviewUserViewController()
    let userDetailViewController = DetailUserViewController()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        configTableView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let alert = alertController {
            // Hiển thị alert và giải phóng biến
            alert.addAction(UIAlertAction(title: Strings.ok, style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            alertController = nil
        }
    }
}

// MARK: - UIViewControllerPreviewingDelegate
extension ListUserViewController: UIViewControllerPreviewingDelegate {
    // PEEK: Hiển thị PreviewUserViewController
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        // Xác định indexPath row của tableView
        guard let indexPath = tableView.indexPathForRow(at: location) else { return nil }
        let cellRect = tableView.rectForRow(at: indexPath)
        let sourceRect = previewingContext.sourceView.convert(cellRect, from: tableView)

        rowIndexPath = indexPath
        previewingContext.sourceRect = sourceRect
        // Widget, height của contentSize có thể thay đổi, nếu muốn nó tự động co dãn theo auto layout thì set thuộc tính đó = 0
        previewUserViewController.preferredContentSize = CGSize(width: 0, height: 500)
        return previewUserViewController
    }

    // POP: Hiển thị DetailUserViewController
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        // Load dữ liệu tương ứng cho POP View & hiển thị
        show(userDetailViewController, sender: self)
    }
}

// MARK: - Extension ListUserViewController
extension ListUserViewController {
    // MARK: Private
    private func configUI() {
        title = "List User"

        // Kiểm tra trạng thái của tính năng 3DTouch trong thiết bị
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: tableView)                // Liên kết tính năng PEEK khi click vào phần tử UI `tableView`
            // Preview Interaction
            previewInteraction = UIPreviewInteraction(view: view)
            previewInteraction.delegate = self
        } else {
            alertController = UIAlertController(title: Strings.deviceNotSupportTitle, message: Strings.deviceNotSupportMessage, preferredStyle: .alert)
        }
    }

    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = Config.rowHeight
        tableView.register(UINib(nibName: Strings.listUserTableCell, bundle: nil), forCellReuseIdentifier: Strings.listUserTableCell)
    }
}


// MARK: - UIPreviewInteractionDelegate
extension ListUserViewController: UIPreviewInteractionDelegate {
    func previewInteraction(_ previewInteraction: UIPreviewInteraction, didUpdatePreviewTransition transitionProgress: CGFloat, ended: Bool) {
        if ended {
            previewUserViewController.viewModel = viewModel.viewModelForUserPreview(at: rowIndexPath)
        }
    }

    func previewInteraction(_ previewInteraction: UIPreviewInteraction, didUpdateCommitTransition transitionProgress: CGFloat, ended: Bool) {
        if ended {
            userDetailViewController.viewModel = viewModel.viewModelForUserDetail(at: rowIndexPath)
        }
    }

    func previewInteractionDidCancel(_ previewInteraction: UIPreviewInteraction) {
        print("-> previewInteractionDidCancel")
    }

    func previewInteractionShouldBegin(_ previewInteraction: UIPreviewInteraction) -> Bool {
        print("-> previewInteractionShouldBegin")
        return true
    }
}

// MARK: - TableView Datasource
extension ListUserViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Strings.listUserTableCell, for: indexPath) as? ListUserTableCell else {
            fatalError("Has an error with cell identifier")
        }

        cell.viewModel = viewModel.viewModelForTableCellItem(at: indexPath)
        return cell
    }
}

// MARK: - TableView Delegate
extension ListUserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let previewUserViewController = PreviewUserViewController()

        tableView.deselectRow(at: indexPath, animated: true)
        previewUserViewController.viewModel = viewModel.viewModelForUserPreview(at: indexPath)
        navigationController?.pushViewController(previewUserViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Config.cellSpacingHeight
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
}

