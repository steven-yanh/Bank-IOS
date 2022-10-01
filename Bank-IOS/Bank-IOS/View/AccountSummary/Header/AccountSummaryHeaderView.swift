//
//  AccountSummaryHeaderView.swift
//  Bank-IOS
//
//  Created by Huang Yan on 9/14/22.
//

import UIKit

class AccountSummaryHeaderView: UIView {
    
    let HStack = UIStackView()
    
    let VStack = UIStackView()
    let bankeyLabel = UILabel()
    let welcomeLabel = UILabel()
    let nameLabel = UILabel()
    let dateLabel = UILabel()
    let sunImageView = UIImageView()
    
    let shakeyBell = ShakeyBellView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        style()
        layout()
        setupShakeyBell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 144)// don't worry about width, but constant height of 144
    }
    
    private func setup() {
        backgroundColor = appColor
    }
    private func style() {
        HStack.translatesAutoresizingMaskIntoConstraints = false
        HStack.axis = .horizontal
        HStack.spacing = 20
        HStack.distribution = .fill
        HStack.alignment = .top
        
        VStack.translatesAutoresizingMaskIntoConstraints = false
        VStack.axis = .vertical
        VStack.spacing = 8
        VStack.distribution = .fill
        VStack.alignment = .fill
        
        bankeyLabel.translatesAutoresizingMaskIntoConstraints = false
        bankeyLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        bankeyLabel.text = "Bankey"
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.text = "welcome"
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Steven"
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont.preferredFont(forTextStyle: .body)
        dateLabel.text = "today"
        
        sunImageView.translatesAutoresizingMaskIntoConstraints = false
        sunImageView.tintColor = .systemYellow
        sunImageView.image = UIImage(systemName: "sun.max.fill")
    }
    private func layout() {
        addSubview(HStack)
        HStack.addArrangedSubview(VStack)
        HStack.addArrangedSubview(sunImageView)
        VStack.addArrangedSubview(bankeyLabel)
        VStack.addArrangedSubview(welcomeLabel)
        VStack.addArrangedSubview(nameLabel)
        VStack.addArrangedSubview(dateLabel)
        //HStack
        NSLayoutConstraint.activate([
            HStack.topAnchor.constraint(equalTo: self.topAnchor),
            HStack.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 2),
            HStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            HStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        //sunImage
        NSLayoutConstraint.activate([
            sunImageView.trailingAnchor.constraint(equalTo: HStack.trailingAnchor),
            sunImageView.topAnchor.constraint(equalTo: HStack.topAnchor),
            sunImageView.heightAnchor.constraint(equalToConstant: 100),
            sunImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        
    }
    private func setupShakeyBell() {
        shakeyBell.translatesAutoresizingMaskIntoConstraints = false
        addSubview(shakeyBell)
        
        NSLayoutConstraint.activate([
            shakeyBell.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            shakeyBell.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
    }
}
//MARK: - ViewModel: update UI
extension AccountSummaryHeaderView {
    func configure(with vm: AccountSummaryHeaderViewModel) {
        vm.configure(with: vm, for: self)
    }
}
