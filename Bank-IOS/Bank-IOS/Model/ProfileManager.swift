//
//  ProfileManager.swift
//  Bank-IOS
//
//  Created by Huang Yan on 9/23/22.
//

import Foundation
struct ProfileManager {
    func fetchProfile(forUserid userId: String,  completion: @escaping (Result<Profile,NetworkError>) -> Void) {
//        let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userId)")!
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil else {
//                completion(.failure(.serverError))
//                return
//            }
//            do {
//                let profile = try JSONDecoder().decode(Profile.self, from: data)
//                completion(.success(profile))
//            } catch {
                completion(.failure(.decodeError))
//            }
//        }.resume()
    }
}
