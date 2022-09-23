//
//  AccountSummaryViewController.swift
//  Bank-IOS
//
//  Created by Huang Yan on 9/11/22.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    
    var tableView = UITableView()
    var accounts = [AccountSummaryCellViewModel]()
    
    var logoutBarButtonItem: UIBarButtonItem {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        barButtonItem.tintColor = .label
        return barButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupNavigationBar()
    }
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
}
//MARK: - prepare tabel
extension AccountSummaryViewController {
    private func setup() {
        setupTableView()
        fetchData()
    }
    
    private func setupTableView() {
        //MARK: Solution to white Gap on top of header
        tableView.backgroundColor = appColor
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func fetchData() {
        let savings = AccountSummaryCellViewModel(accountType: .Banking,
                                                            accountName: "Basic Savings",
                                                        balance: 929466.23)
        let chequing = AccountSummaryCellViewModel(accountType: .Banking,
                                                    accountName: "No-Fee All-In Chequing",
                                                    balance: 17562.44)
        let visa = AccountSummaryCellViewModel(accountType: .CreditCard,
                                                       accountName: "Visa Avion Card",
                                                       balance: 412.83)
        let masterCard = AccountSummaryCellViewModel(accountType: .CreditCard,
                                                       accountName: "Student Mastercard",
                                                       balance: 50.83)
        let investment1 = AccountSummaryCellViewModel(accountType: .Investment,
                                                       accountName: "Tax-Free Saver",
                                                       balance: 2000.00)
        let investment2 = AccountSummaryCellViewModel(accountType: .Investment,
                                                       accountName: "Growth Fund",
                                                       balance: 15000.00)

        accounts.append(savings)
        accounts.append(chequing)
        accounts.append(visa)
        accounts.append(masterCard)
        accounts.append(investment1)
        accounts.append(investment2)
    }
}
//MARK: - TableViewDatasouce
extension AccountSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !accounts.isEmpty else { return UITableViewCell()}
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
        let account = accounts[indexPath.row]
        cell.configure(with: account, for: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
}
//MARK: - TableViewDelegate
extension AccountSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return AccountSummaryHeaderView()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 144
    }
}
//MARK: - Actions
extension AccountSummaryViewController {
    @objc func logoutTapped() {
        NotificationCenter.default.post(name: .logout, object: nil)
    }
}
