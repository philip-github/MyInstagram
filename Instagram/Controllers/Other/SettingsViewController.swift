//
//  SettingsViewController.swift
//  Instagram
//
//  Created by Philip Twal on 8/13/22.
//
import SafariServices
import UIKit


struct SettingCellModal {
    var title: String
    var completion: (() -> Void)
}

public enum WebViewsURLS: String {
    case terms = "https://help.instagram.com/581066165581870"
    case privacy = "https://help.instagram.com/155833707900388"
    case help = "https://help.instagram.com/"
}

final class SettingsViewController: UIViewController {
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private enum Constants: String {
        case editProfile = "Edit Profile"
        case inviteFriends = "Invite Friends"
        case saveOriginalPosts = "Save Original Posts"
        case termsOfUse = "Terms Of Use"
        case privacyPolicy = "Pirvacy Policy"
        case help = "Help / Feedback"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        ConfigureModel()
        self.tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private var data = [[SettingCellModal]]()
    
    private func ConfigureModel() {
        
        data.append([
            SettingCellModal(title: Constants.editProfile.rawValue, completion: { [weak self] in
                self?.didTapEditProfile()
            }),
            SettingCellModal(title: Constants.inviteFriends.rawValue, completion: { [weak self] in
                self?.didTapInviteFriends()
            }),
            SettingCellModal(title: Constants.saveOriginalPosts.rawValue, completion: { [weak self] in
                self?.didTapSaveOriginalPosts()
            })
        ])
        
        data.append([
            SettingCellModal(title: Constants.termsOfUse.rawValue, completion: { [weak self] in
                self?.openWebView(web: .terms)
            }),
            SettingCellModal(title: Constants.privacyPolicy.rawValue, completion: { [weak self] in
                self?.openWebView(web: .privacy)
            }),
            SettingCellModal(title: Constants.help.rawValue, completion: { [weak self] in
                self?.openWebView(web: .help)
            })
        ])
        
        data.append([
            SettingCellModal(title: "Log Out", completion: { [weak self] in
                self?.didTapLogOut()
            })
        ])
    }
    
    func didTapLogOut(){
        let actionSheet = UIAlertController(title: "Log Out", message: "Are you sure you want to log out ?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            AuthManager.shared.logOut { [weak self] loggedOut in
                DispatchQueue.main.async {
                    if loggedOut{
                        let vc = LoginViewController()
                        vc.modalPresentationStyle = .fullScreen
                        self?.present(vc, animated:  true) {
                            self?.navigationController?.popToRootViewController(animated: false)
                            self?.tabBarController?.selectedIndex = 0
                        }
                    }else{
                        fatalError()
                    }
                }
            }
        }))
        DispatchQueue.main.async {
            self.present(actionSheet, animated: true)
        }
    }
}


extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].completion()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
}



extension SettingsViewController {
    
    private func didTapEditProfile(){
        let vc = EditProfileViewController()
        vc.title = Constants.editProfile.rawValue
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    private func didTapInviteFriends(){
        
    }
    
    private func didTapSaveOriginalPosts(){
        
    }
    
    private func openWebView(web: WebViewsURLS){
        var url: String
        switch web{
        case .terms:
            url = WebViewsURLS.terms.rawValue
        case .privacy:
            url = WebViewsURLS.privacy.rawValue
        case .help:
            url = WebViewsURLS.help.rawValue
        }
        
        guard let url = URL(string: url) else { return }
        let vc = SFSafariViewController(url: url)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
