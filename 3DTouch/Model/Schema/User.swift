//
//  User.swift
//  3DTouch
//
//  Created by Duy Tran N. on 1/8/18.
//  Copyright © 2018 Asiantech. All rights reserved.
//

import Foundation

final class User {
    var age: UInt = 0
    var userName = ""
    var position = ""
    var imageName = ""
    var description = ""
    var backgroundImageName = ""

    init(userName: String, imageName: String, backgroundImageName: String, age: UInt, position: String, description: String) {
        self.age = age
        self.userName = userName
        self.position = position
        self.imageName = imageName
        self.description = description
        self.backgroundImageName = backgroundImageName
    }
}
