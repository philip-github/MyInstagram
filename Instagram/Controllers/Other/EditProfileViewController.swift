//
//  EditProfileViewController.swift
//  Instagram
//
//  Created by Philip Twal on 8/13/22.
//

import UIKit
struct ProfileEditModel {
    let label: String
    let placeholder: String
    var value: String?
}


class EditProfileViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier)
        return tableView
    }()
    
    private var models = [[ProfileEditModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationBarItems()
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        configureModels()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        tableView.tableHeaderView = configureTableHeaderView()
    }
    
    
    @objc private func chnageProfilePicButtonTapped(){
        uploadProfilePic()
    }
    
    func configureModels(){
        let section1Lables = ["Name", "Username", "Bio"]
        var section1 = [ProfileEditModel]()
        for label in section1Lables {
            let object = ProfileEditModel(label: label, placeholder: "Enter \(label)...", value: nil)
            section1.append(object)
        }
        models.append(section1)
        
        let section2Lables = ["Email", "Phone Number", "Gender"]
        var section2 = [ProfileEditModel]()
        for label in section2Lables {
            let object = ProfileEditModel(label: label, placeholder: "Enter \(label)...", value: nil)
            section2.append(object)
        }
        models.append(section2)
    }
    
    func configureTableHeaderView() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: view.width,
                                              height: view.height/3.0).integral)
        
        let size = headerView.height/1.9
        
        let profilePictureButton = UIButton(frame: CGRect(x: (view.width - size)/2,
                                                          y: (headerView.height - size)/2,
                                                          width: size,
                                                          height: size))
        headerView.addSubview(profilePictureButton)
        
        profilePictureButton.layer.masksToBounds = true
        profilePictureButton.layer.cornerRadius = profilePictureButton.height/2
        profilePictureButton.tintColor = .label
        profilePictureButton.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        profilePictureButton.layer.borderWidth = 1.5
        profilePictureButton.layer.borderColor = UIColor.secondaryLabel.cgColor
        profilePictureButton.addTarget(self, action: #selector(uploadProfilePic), for: .touchUpInside)
        return headerView
    }
    
    func configureNavigationBarItems(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
    }
    
    @objc private func didTapSave(){
        dismiss(animated: true) {
            //
        }
    }
    
    @objc private func didTapCancel(){
        dismiss(animated: true) {
            //
        }
    }
    
    @objc func uploadProfilePic(){
        let actionSheet = UIAlertController(title: "Profile Pic", message: "Choose Profile Pic", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Choose From Library", style: .default, handler: { _ in
            //
        }))
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            //
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true)
    }
}


extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier, for: indexPath) as? FormTableViewCell else { return FormTableViewCell()}
        cell.delegate = self
        cell.configure(model: models[indexPath.section][indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section != 0 else { return nil }
        return "Private Information"
    }
}


extension EditProfileViewController: FormTableViewCellDelegate {
    func formTableViewCell(for cell: FormTableViewCell, with model: ProfileEditModel) {
        print("Label: \(model.label)  Value: \(model.value ?? "Nil")")
    }
}
