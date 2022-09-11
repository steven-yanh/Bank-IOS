//
//  DecimalUtils.swift
//  Bank-IOS
//
//  Created by Huang Yan on 9/16/22.
//

import Foundation
extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
