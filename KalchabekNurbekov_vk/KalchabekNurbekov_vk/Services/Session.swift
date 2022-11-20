//
//  Session.swift
//  KalchabekNurbekov_vk
//
//  Created by Kalchabek Nurbekov on 09.06.2022.
//

import Foundation

class Session {

    static let instance = Session()
    private init() {}

    var token: String? // токен ВК
    var userId: Int?// Идентификатор пользователя ВК
}
