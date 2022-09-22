//
//  AccountSummaryHeaderView.swift
//  Bank-IOS
//
//  Created by Huang Yan on 9/14/22.
//

import UIKit

class AccountSummaryHeaderView: UIView {
    
    @IBOutlet var contentView: UIView!
    let shakeyBell = ShakeyBellView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 144)// don't worry about width, but constant height of 144
    }
    
    private func commonInit() {
        let bundle = Bundle(for: AccountSummaryHeaderView.self)
        bundle.loadNibNamed("AccountSummaryHeaderView", owner: self, options: nil) // code to load up the bundle
        addSubview(contentView)
        
        contentView.backgroundColor = appColor // set background color
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        setupShakeyBell()
    }
    private func setupShakeyBell() {
        shakeyBell.translatesAutoresizingMaskIntoConstraints = false
        addSubview(shakeyBell)
        
        NSLayoutConstraint.activate([
            shakeyBell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            shakeyBell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
    }
}
