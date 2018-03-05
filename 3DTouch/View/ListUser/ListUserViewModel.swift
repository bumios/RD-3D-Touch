//
//  ListUserViewModel.swift
//  3DTouch
//
//  Created by Duy Tran N. on 1/8/18.
//  Copyright © 2018 Asiantech. All rights reserved.
//

import Foundation
import MVVM

final class ListUserViewModel: MVVM.ViewModel {
    // MARK: - Properties
    var users: [User] = [
        User(userName: "Biên Lê", imageName: "bienbien", backgroundImageName: "background1", age: 23, position: "Associate Software Engineer", description: Strings.loremText),
        User(userName: "Phú Trần", imageName: "phutran", backgroundImageName: "background2", age: 26, position: "Associate Software Engineer", description: Strings.loremText),
        User(userName: "Phát Nguyễn", imageName: "phatnguyen", backgroundImageName: "background3", age: 23, position: "Associate Software Engineer", description: Strings.loremText),
        User(userName: "Tùng Nguyễn", imageName: "tungnguyen", backgroundImageName: "background4", age: 23, position: "Associate Software Engineer", description: Strings.loremText),
        User(userName: "Duy Trần", imageName: "duytran", backgroundImageName: "background5", age: 22, position: "Associate Software Engineer", description: Strings.loremText),
        User(userName: "Sơn Vũ", imageName: "sonson", backgroundImageName: "background6", age: 23, position: "Associate Software Engineer", description: Strings.loremText),
        User(userName: "Tánh Lê", imageName: "tanhle", backgroundImageName: "background7", age: 23, position: "Associate Software Engineer", description: Strings.loremText),
        User(userName: "Lý Trương", imageName: "tungnguyen", backgroundImageName: "background8", age: 24, position: "Associate Software Engineer", description: Strings.loremText),
        User(userName: "Đạt Phùng", imageName: "datdat", backgroundImageName: "background9", age: 22, position: "Associate Software Engineer", description: Strings.loremText)
    ]

    // MARK: - Public
    func numberOfSections() -> Int {
        return users.count
    }

    func viewModelForTableCellItem(at indexPath: IndexPath) -> ListUserTableCellViewModel {
        let userDetail = users[indexPath.section]
        return ListUserTableCellViewModel(user: userDetail)
    }

    func viewModelForUserPreview(at indexPath: IndexPath) -> PreviewUserViewModel {
        let userDetail = users[indexPath.section]
        return PreviewUserViewModel(user: userDetail)
    }

    func viewModelForUserDetail(at indexPath: IndexPath) -> DetailUserViewModel {
        let userDetail = users[indexPath.section]
        return DetailUserViewModel(user: userDetail)
    }
}
