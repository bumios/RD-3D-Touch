//
//  PreviewUserViewModel.swift
//  3DTouch
//
//  Created by Duy Tran N. on 1/8/18.
//  Copyright © 2018 Asiantech. All rights reserved.
//

import Foundation
import MVVM

final class PreviewUserViewModel: MVVM.ViewModel {
    // MAKR: - Properties
    var user: User?

    // MAKR: - Life Cycle
    init(user: User) {
        self.user = user
    }

    // MAKR: - Public
    func viewModelForUserDetail() -> DetailUserViewModel {
        guard let user = user else {
            return DetailUserViewModel(user: nil)
        }
        return DetailUserViewModel(user: user)
    }
}
