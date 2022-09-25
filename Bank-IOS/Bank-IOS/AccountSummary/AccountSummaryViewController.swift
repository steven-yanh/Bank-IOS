//
//  AccountSummaryViewController.swift
//  Bank-IOS
//
//  Created by Huang Yan on 9/11/22.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    
    //Request model
    var profile: Profile?
    var accounts: [Account] = []
    
    //ViewModels
    var accountCellViewModels = [AccountSummaryCellViewModel]()
    var headerViewModel = AccountSummaryHeaderViewModel(welcomeMessage: "welcome", name: "Steven", date: Date())
    
    //components
    let refreshControl = UIRefreshControl()
    var tableView = UITableView()
    var tabelViewHeader = AccountSummaryHeaderView()
    
    var logoutBarButtonItem: UIBarButtonItem {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        barButtonItem.tintColor = .label
        return barButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}
//MARK: - prepare tabel
extension AccountSummaryViewController {
    private func setup() {
        setupTableView()
        setupRefreshControl()
        fetchData()
        setupNavigationBar()
    }
    
    private func setupTableView() {
        //MARK: Solution to white Gap on top of header
        tableView.backgroundColor = appColor
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView()
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupRefreshControl() {
        refreshControl.tintColor = appColor
        refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        tableView.refreshControl = self.refreshControl
    }
    
    private func fetchData() {
        let group = DispatchGroup()
        //Profile fetching
        group.enter()
        ProfileManager().fetchProfile(forUserid: "1") { result in
            switch result {
            case .success(let profile):
                self.profile = profile
                self.configureTableHeaderView(with: profile)
            case .failure(let error):
                print(error.localizedDescription)
            }
            group.leave()
        }
        group.enter()
        //Accounts fetching
        AccountManager().fetchAccounts(forUserId: "1") { result in
            switch result {
            case .success(let accounts):
                self.accounts = accounts
                self.configureTabelCellView(with: accounts)
            case .failure(let error):
                print(error.localizedDescription)
            }
            group.leave()
        }
        group.notify(queue: .main) {
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
    
}
//MARK: - TableViewDatasouce
extension AccountSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !accountCellViewModels.isEmpty else { return UITableViewCell()}
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
        let account = accountCellViewModels[indexPath.row]
        cell.configure(with: account, for: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountCellViewModels.count
    }
}
//MARK: - TableViewDelegate
extension AccountSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vm = AccountSummaryHeaderViewModel(welcomeMessage: "Good morning,",
                                               name: profile?.firstName ?? "Steven",
                                                    date: Date())
        tabelViewHeader.configure(with: vm)
        return tabelViewHeader
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
    
    @objc func refreshContent() {
        fetchData()
    }
    
}
// MARK: - Networking
extension AccountSummaryViewController {
    private func configureTableHeaderView(with profile: Profile) {
            let vm = AccountSummaryHeaderViewModel(welcomeMessage: "Good morning,",
                                                        name: profile.firstName,
                                                        date: Date())
            DispatchQueue.main.async {
                self.headerViewModel.configure(with: vm, for: self.tabelViewHeader)
                self.tableView.reloadData()

            }
        }
        private func configureTabelCellView(with accounts: [Account]) {
            accountCellViewModels = accounts.map {
                AccountSummaryCellViewModel(accountType: $0.type, accountName: $0.name, balance: $0.amount)
            }

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
}
