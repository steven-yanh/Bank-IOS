//
//  Profile.swift
//  Bank-IOS
//
//  Created by Huang Yan on 9/23/22.
//

import Foundation
struct Profile: Codable {
    let id: String
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey{
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
    
}
enum NetworkError: Error {
    case serverError
    case decodeError
}

