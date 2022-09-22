//
//  AccountSummaryCellViewModel.swift
//  Bank-IOS
//
//  Created by Huang Yan on 9/22/22.
//
import Foundation
struct AccountSummaryCellViewModel {
    
    enum AccountType: String {
        case Banking
        case CreditCard
        case Investment
    }
    let accountType: AccountType
    let accountName: String
    let balance: Decimal
    var balanceAsAttributedString: NSAttributedString {
        return CurrencyFormatter().makeAttributedCurrency(balance)
    }
    
    func configure(with vm: AccountSummaryCellViewModel, for cell: AccountSummaryCell) {
        cell.typeLabel.text = vm.accountType.rawValue
        cell.nameLabel.text = vm.accountName
        cell.balanceAmountLabel.attributedText = vm.balanceAsAttributedString
        switch vm.accountType {
        case .Banking:
            cell.underLineView.backgroundColor = appColor
            cell.balanceLabel.text = "Current Balance"
        case .CreditCard:
            cell.underLineView.backgroundColor = .systemOrange
            cell.balanceLabel.text = "Current Balance"
        case .Investment:
            cell.underLineView.backgroundColor = .systemPurple
            cell.balanceLabel.text = "Total Assets"
        }
    }
}
