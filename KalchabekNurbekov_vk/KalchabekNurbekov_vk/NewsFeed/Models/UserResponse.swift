//
//  UserResponse.swift
//  KalchabekNurbekov_vk
//
//  Created by Kalchabek Nurbekov on 15.11.2022.
//

import Foundation

struct UserResponseWrapped: Decodable {
    let response: [UserResponse]
    
}
struct UserResponse: Decodable {
    let photo100: String?
    
}
