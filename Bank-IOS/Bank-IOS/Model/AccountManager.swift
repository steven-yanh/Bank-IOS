//
//  AccountManager.swift
//  Bank-IOS
//
//  Created by Huang Yan on 9/24/22.
//

import Foundation

struct AccountManager {
    func fetchAccounts(forUserId userId: String, completion: @escaping (Result<[Account],NetworkError>) -> Void) {
        let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userId)/accounts")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("xx")
                completion(.failure(.serverError))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let accounts = try decoder.decode([Account].self, from: data)
                completion(.success(accounts))
            } catch {
                completion(.failure(.decodeError))
            }
        }.resume()
    }
}
