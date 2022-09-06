//
//  ProfileInfoHeaderCollectionReusableView.swift
//  Instagram
//
//  Created by Philip Twal on 8/23/22.
//

import UIKit

protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject {
    func postsButtonDidTapped(for cell: ProfileInfoHeaderCollectionReusableView)
    func followersButtonDidTapped(for cell: ProfileInfoHeaderCollectionReusableView)
    func followingButtonDidTapped(for cell: ProfileInfoHeaderCollectionReusableView)
    func editPorfileButtonDidTapped(for cell: ProfileInfoHeaderCollectionReusableView)
}


class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    public weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let postsButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let followersButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let followingButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let editPorfileButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let nameLable: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let bioLable: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        backgroundColor = .systemBackground
        clipsToBounds = true
        addButtonsActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureSubviews()
    }
    
    private func addSubviews(){
        addSubview(profileImageView)
        addSubview(postsButton)
        addSubview(followersButton)
        addSubview(followingButton)
        addSubview(editPorfileButton)
        addSubview(nameLable)
        addSubview(bioLable)
    }
    
    private func addButtonsActions(){
        postsButton.addTarget(self, action: #selector(postsButtonTapped), for: .touchUpInside)
        followersButton.addTarget(self, action: #selector(followersButtonTapped), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(followingButtonTapped), for: .touchUpInside)
        editPorfileButton.addTarget(self, action: #selector(editPorfileButtonTapped), for: .touchUpInside)
    }
    
    private func configureSubviews(){
        
        //MARK: Profile Image View Configuration
        profileImageView.frame = CGRect(x: 10,
                                        y: self.safeAreaInsets.top + 10,
                                        width: (self.width - 10)/4,
                                        height: (self.width - 10)/4).integral
        profileImageView.layer.masksToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = profileImageView.height/2.0
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.secondaryLabel.cgColor
        profileImageView.tintColor = .systemBackground
        profileImageView.image = UIImage(named: "test-image")
        
        
        //MARK: Name Label Configuration
        nameLable.frame = CGRect(x: 10,
                                 y: profileImageView.bottom + 10,
                                 width: self.width/4,
                                 height: 30).integral
        nameLable.numberOfLines = 1
        nameLable.adjustsFontSizeToFitWidth = true
        nameLable.layer.masksToBounds = true
        nameLable.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        nameLable.textColor = .label
        nameLable.text = "Philip Al-Twal"
        
        
        //MARK: Bio Lable Configuration
        let bioSize = bioLable.sizeThatFits(frame.size)
        bioLable.frame = CGRect(x: 10,
                                y: nameLable.bottom + 10,
                                width: bioSize.width/1.1,
                                height: bioSize.height)
        bioLable.numberOfLines = 0
        bioLable.layer.masksToBounds = true
        bioLable.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        bioLable.textColor = .label
        bioLable.text = "Workout vids, dog pics, motivational quotes served over a bed of sarcasm"
        
        
        //MARK: Post Button Configuration
        postsButton.frame = CGRect(x: profileImageView.right + 20,
                                   y: self.safeAreaInsets.top + 20,
                                   width: (self.width-5)/5,
                                   height: 15).integral
        postsButton.setTitle("Posts", for: .normal)
        postsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        postsButton.setTitleColor(.label, for: .normal)
        
        
        //MARK: Followers Button Configuration
        followersButton.frame = CGRect(x: postsButton.right,
                                       y: self.safeAreaInsets.top + 20,
                                       width: (self.width-5)/5,
                                       height: 15).integral
        followersButton.setTitle("Followers", for: .normal)
        followersButton.titleLabel?.adjustsFontSizeToFitWidth = true
        followersButton.setTitleColor(.label, for: .normal)
        
        
        //MARK: Following Button Configuration
        followingButton.frame = CGRect(x: followersButton.right + 10,
                                       y: self.safeAreaInsets.top + 20,
                                       width: (self.width-5)/5,
                                       height: 15).integral
        followingButton.setTitle("Following", for: .normal)
        followingButton.titleLabel?.adjustsFontSizeToFitWidth = true
        followingButton.setTitleColor(.label, for: .normal)
        
        
        //MARK: Edit Profile Button Configuration
        editPorfileButton.frame = CGRect(x: profileImageView.right + 20,
                                         y: profileImageView.bottom + 10,
                                         width: (self.width-10)/1.5,
                                         height: 20).integral
        editPorfileButton.setTitle("Edit Profile", for: .normal)
        editPorfileButton.setTitleColor(.label, for: .normal)
        editPorfileButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        editPorfileButton.layer.cornerRadius = 5.0
    }
}


//MARK: Buttons Targets / Delegates
extension ProfileInfoHeaderCollectionReusableView {
    
    @objc private func postsButtonTapped(){
        delegate?.postsButtonDidTapped(for: self)
    }
    
    @objc private func followersButtonTapped(){
        delegate?.followersButtonDidTapped(for: self)
    }
    
    @objc private func followingButtonTapped(){
        delegate?.followingButtonDidTapped(for: self)
    }
    
    @objc private func editPorfileButtonTapped(){
        delegate?.editPorfileButtonDidTapped(for: self)
    }
}
