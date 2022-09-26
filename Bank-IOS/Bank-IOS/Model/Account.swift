//
//  Account.swift
//  Bank-IOS
//
//  Created by Huang Yan on 9/24/22.
//

import Foundation
struct Account: Codable {
    let id: String
    let type: AccountType
    let name: String
    let amount: Decimal
    let createdDateTime: Date
    
    static func makeSkeleton() -> Account {
        return Account(id: "1", type: .Banking, name: "Account Name", amount: 0.0, createdDateTime: Date())
    }
    
}


enum AccountType: String, Codable {
    case Banking
    case CreditCard
    case Investment
}
