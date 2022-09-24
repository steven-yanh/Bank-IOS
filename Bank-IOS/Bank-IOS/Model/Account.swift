//
//  Account.swift
//  Bank-IOS
//
//  Created by Huang Yan on 9/24/22.
//

import Foundation
enum AccountType: String, Codable {
    case Banking
    case CreditCard
    case Investment
}
struct Account: Codable {
    let id: String
    let type: AccountType
    let name: String
    let amount: Decimal
    let createdDateTime: Date
        
    
}
