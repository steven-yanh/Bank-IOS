//
//  AccountSummaryCell.swift
//  Bank-IOS
//
//  Created by Huang Yan on 9/15/22.
//

import UIKit

class AccountSummaryCell: UITableViewCell {
    
    
    static let reuseID = "AccountSummaryCell"
    static let rowHeight: CGFloat = 112
    
    let typeLabel = UILabel()
    let underLineView = UIView()
    let nameLabel = UILabel()
    
    let stackView = UIStackView()
    let balanceLabel = UILabel()
    let balanceAmountLabel = UILabel()
    let chevronImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//MARK: - setting up
extension AccountSummaryCell {
    private func setup() {
        
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        typeLabel.adjustsFontForContentSizeCategory = true
        typeLabel.text = "Account Type:"
        
        
        underLineView.translatesAutoresizingMaskIntoConstraints = false
        underLineView.backgroundColor = appColor
        underLineView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        underLineView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.adjustsFontSizeToFitWidth = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0
        
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        balanceLabel.textAlignment = .right
        balanceLabel.adjustsFontSizeToFitWidth = true
        
        balanceAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceAmountLabel.textAlignment = .right
        
        
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        chevronImageView.image = UIImage(systemName: "chevron.right")
        chevronImageView.tintColor = appColor
        
        
        
    }
    private func layout() {
        contentView.addSubview(typeLabel) // **** Important! to add contentView. in tableCell
        contentView.addSubview(underLineView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(balanceLabel)
        stackView.addArrangedSubview(balanceAmountLabel)
        contentView.addSubview(chevronImageView)
        
        
        //typelabel
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            typeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2)
        ])
        //underline
        NSLayoutConstraint.activate([
            underLineView.topAnchor.constraint(equalToSystemSpacingBelow: typeLabel.bottomAnchor, multiplier: 1),
            underLineView.leadingAnchor.constraint(equalTo: typeLabel.leadingAnchor)
        ])
        //namelabel
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: underLineView.bottomAnchor, multiplier: 2),
            nameLabel.leadingAnchor.constraint(equalTo: typeLabel.leadingAnchor)
        ])
        //stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: underLineView.bottomAnchor, multiplier: 0),
            chevronImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2)
            
        ])
        //chevronImage
        NSLayoutConstraint.activate([
            chevronImageView.topAnchor.constraint(equalToSystemSpacingBelow: underLineView.bottomAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: chevronImageView.trailingAnchor, multiplier: 1)
        ])
    }
//    private func makeFormattedBalance(dollors: String, cents: String) -> NSMutableAttributedString {
//        let dollarSignAttributes: [NSAttributedString.Key: Any] = [.font : UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
//        let dollarAttributes: [NSAttributedString.Key: Any] = [.font : UIFont.preferredFont(forTextStyle: .title1)]
//        let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset: 8]
//
//        let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes)
//        let dollarString = NSMutableAttributedString(string: dollors, attributes: dollarAttributes)
//        let centString = NSMutableAttributedString(string: cents, attributes: centAttributes)
//
//        rootString.append(dollarString)
//        rootString.append(centString)
//
//        return rootString
//
//    }
}

//MARK: - configure cell for ViewModel
extension AccountSummaryCell {
    func configure(with vm: AccountSummaryCellViewModel,for cell: AccountSummaryCell) {
        vm.configure(with: vm, for: self)
    }
}
