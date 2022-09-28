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
    var isloaded = false
    
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
        setupSkeletons()
        fetchData()
        setupNavigationBar()
    }
    
    private func setupTableView() {
        //MARK: Solution to white Gap on top of header
        tableView.backgroundColor = appColor
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.register(SkeletonCell.self, forCellReuseIdentifier: SkeletonCell.reuseID)
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
    private func setupSkeletons() {
        let skeleton = Account.makeSkeleton()
        accounts = Array.init(repeating: skeleton, count: 10)
        configureTabelCellView(with: accounts)
    }
    
    private func fetchData() {
        let group = DispatchGroup()
        //Profile fetching
        group.enter()
        ProfileManager().fetchProfile(forUserid: "1") { result in
            switch result {
            case .success(let profile):
                self.profile = profile
            case .failure(let error):
                self.displayError(error: error)
            }
            group.leave()
        }
        group.enter()
        //Accounts fetching
        AccountManager().fetchAccounts(forUserId: "1") { result in
            switch result {
            case .success(let accounts):
                self.accounts = accounts
            case .failure(let error):
                self.displayError(error: error)
            }
            group.leave()
        }
        group.notify(queue: .main) {
            self.tableView.refreshControl?.endRefreshing()
            guard let profile = self.profile else { return } //guard let makes it very useful when fetch profile fails, it make sures the following statment does NOT trigger AND should not trigger!
            
            
            self.isloaded = true
            self.configureTableHeaderView(with: profile)
            self.configureTabelCellView(with: self.accounts)
            self.tableView.reloadData()
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
        
        if isloaded {
            let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
            let account = accountCellViewModels[indexPath.row]
            cell.configure(with: account, for: cell)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: SkeletonCell.reuseID, for: indexPath) as! SkeletonCell
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
        reset()
        setupSkeletons()
        tableView.reloadData()
        fetchData()
    }
    private func reset() {
        profile = nil
        accounts = []
        isloaded = false
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
            return  AccountSummaryCellViewModel(accountType: $0.type, accountName: $0.name, balance: $0.amount)
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
//MARK: - Error handling
extension AccountSummaryViewController {
    private func displayError(error: NetworkError) {
        let title: String
        let message: String
        switch error {
        case .serverError:
            title = "Server Error"
            message = "Ensure you are connected to the internet. Please try again."
        case .decodeError:
            title = "Decoding Error"
            message = "We could not process your request. Please try again."
        }
        self.showAlert(title: title, message: message)
    }
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: "No network connection was detected", preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(action)
        present(alert,animated: true)
        
    }
}
