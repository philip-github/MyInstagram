//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Philip Twal on 8/13/22.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    private var userPosts = [UserPost]()
    private var userRelation = [UserRelation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        configureBarItem()
        configureCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    private func configureCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (view.width - 4)/3, height: (view.width - 4)/3)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        collectionView.register(ProfileInfoHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier)
        collectionView.register(ProfileTabsCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileTabsCollectionReusableView.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
    }
    
    private func configureBarItem(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(DidTapSettingBarButton))
        
        navigationController?.navigationBar.tintColor = .secondaryLabel
    }
    
    @objc private func DidTapSettingBarButton(){
        let vc = SettingsViewController()
        vc.title = "Settings"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


//MARK: Collection View Delegate Methodes
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 0
        }
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let _ = userPosts[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else { return PhotoCollectionViewCell()}
        cell.configure(debug: "test-image")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let data = userPosts[indexPath.row]
        let vc = PostViewController(model: nil)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        
        if indexPath.section == 1 {
            let tabBarHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileTabsCollectionReusableView.identifier, for: indexPath) as! ProfileTabsCollectionReusableView
            tabBarHeader.delegate = self
            return tabBarHeader
        }
        
        let profileHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier, for: indexPath) as! ProfileInfoHeaderCollectionReusableView
        profileHeader.delegate = self
        return profileHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.width, height: collectionView.height/3.0)
        }
        return CGSize(width: collectionView.width, height: 50)
    }
}


//MARK: Header View Buttons Delegate
extension ProfileViewController: ProfileInfoHeaderCollectionReusableViewDelegate, ProfileTabsCollectionReusableViewDelegate {
    
    func postsButtonDidTapped(for: ProfileInfoHeaderCollectionReusableView) {
        collectionView?.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
    }
    
    func followersButtonDidTapped(for: ProfileInfoHeaderCollectionReusableView) {
        //MARK:- Test Mock Data
        var mockData = [UserRelation]()
        for i in 0...10 {
            mockData.append(UserRelation(name: "Phil", username: "@Phil", profileImage: UIImage(named: "test-image")!, followingStatus: i % 2 == 0 ? .following : .un_following))
        }
        let vc = ListViewController(data: mockData)
        vc.title = "Followers"
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func followingButtonDidTapped(for: ProfileInfoHeaderCollectionReusableView) {
        var mockData = [UserRelation]()
        for i in 0...10 {
            mockData.append(UserRelation(name: "Phil", username: "@Phil", profileImage: UIImage(named: "test-image")!, followingStatus: i % 2 == 0 ? .following : .un_following))
        }
        let vc = ListViewController(data: mockData)
        vc.title = "Following"
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func editPorfileButtonDidTapped(for: ProfileInfoHeaderCollectionReusableView) {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav,animated: true)
    }
    
    func didTapGridButton(for cell: ProfileTabsCollectionReusableView) {
        print("didTapGridButton")
    }
    
    func didTapTaggedButton(for cell: ProfileTabsCollectionReusableView) {
        print("didTapTaggedButton")
    }
}
