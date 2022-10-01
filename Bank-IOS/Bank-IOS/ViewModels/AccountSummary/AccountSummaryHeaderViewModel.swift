//
//  AccountSummaryHeaderViewModel.swift
//  Bank-IOS
//
//  Created by Huang Yan on 9/23/22.
//

import UIKit
struct AccountSummaryHeaderViewModel {
    let welcomeMessage: String
    let name: String
    let date: Date
    
    var dateFormatted: String {
        return date.monthDayYearString
    }
    
}
extension AccountSummaryHeaderViewModel{
    func configure(with vm: AccountSummaryHeaderViewModel,for view: AccountSummaryHeaderView ) {
        view.welcomeLabel.text = vm.welcomeMessage
        view.nameLabel.text = vm.name
        view.dateLabel.text = vm.dateFormatted
    }
}
