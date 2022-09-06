//
//  UserFollowTableViewCell.swift
//  Instagram
//
//  Created by Philip Twal on 8/29/22.
//

import UIKit

protocol UserFollowTableViewCellDelegate: AnyObject{
    func didTapfollowUnfollowButton(for cell: UserFollowTableViewCell, with: UserRelation)
}

enum FollowState {
    case following
    case un_following
}

struct UserRelation {
    var name: String
    var username: String
    var profileImage: UIImage
    var followingStatus: FollowState
}

class UserFollowTableViewCell: UITableViewCell {
    
    static let identifier = "UserFollowTableViewCell"
    
    public weak var delegate: UserFollowTableViewCellDelegate?
    
    private var model: UserRelation?
    
    private let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let namelabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let username: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let followUnfollowButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        addSubviews()
        followUnfollowButton.addTarget(self, action: #selector(followUnfollowButtontapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureSubViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userProfileImageView.image = nil
        namelabel.text = nil
        username.text = nil
        followUnfollowButton.setTitle(nil, for: .normal)
        followUnfollowButton.layer.borderWidth = 0
        followUnfollowButton.backgroundColor = nil
    }
    
    private func addSubviews(){
        contentView.addSubview(userProfileImageView)
        contentView.addSubview(namelabel)
        contentView.addSubview(username)
        contentView.addSubview(followUnfollowButton)
    }
    
    private func configureSubViews(){
        //MARK: User Profile Image View Configurations
        userProfileImageView.frame = CGRect(x: contentView.left + 6,
                                            y: (contentView.height)/2 - ((contentView.height - 3)/1.5)/2,
                                            width: (contentView.height - 3)/1.5,
                                            height: (contentView.height - 3)/1.5).integral
        userProfileImageView.contentMode = .scaleAspectFit
        userProfileImageView.layer.masksToBounds = true
        userProfileImageView.layer.cornerRadius = userProfileImageView.height/2
        userProfileImageView.layer.borderWidth = 1.0
        userProfileImageView.layer.borderColor = UIColor.secondaryLabel.cgColor
        
        
        //MARK: Username Label Configuration
        namelabel.frame = CGRect(x: userProfileImageView.right + 10,
                                y: (contentView.height)/2 - (contentView.height/3),
                                width: contentView.width/3,
                                height: contentView.height/3).integral
        namelabel.numberOfLines = 1
        namelabel.clipsToBounds = true
        namelabel.adjustsFontSizeToFitWidth = true
        namelabel.textColor = .label
        
        
        //MARK: Username Label Configuration
        username.frame = CGRect(x: userProfileImageView.right + 10,
                                y: (contentView.height)/2,
                                width: contentView.width/3,
                                height: contentView.height/3).integral
        username.clipsToBounds = true
        username.adjustsFontSizeToFitWidth = true
        username.numberOfLines = 1
        username.textColor = .label
        
        
        //MARK: Follow/UnFollow Button Configuration
        followUnfollowButton.frame = CGRect(x: contentView.right - (contentView.width/3) - 5,
                                            y: (contentView.height)/2 - (contentView.height/3)/2,
                                            width: contentView.width/4,
                                            height: contentView.height/3).integral
    }
    
    public func configure(with model: UserRelation) {
        self.model = model
        userProfileImageView.image = model.profileImage
        username.text = model.username
        namelabel.text = model.name
        switch model.followingStatus{
        case .following:
            followUnfollowButton.setTitle("Unfollow", for: .normal)
            followUnfollowButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            followUnfollowButton.setTitleColor(.label, for: .normal)
        case .un_following:
            followUnfollowButton.setTitle("Follow", for: .normal)
            followUnfollowButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            followUnfollowButton.setTitleColor(.link, for: .normal)
        }
    }
    
    @objc private func followUnfollowButtontapped(){
        guard let myModel = model else { return }
        delegate?.didTapfollowUnfollowButton(for: self, with: myModel)
    }
}
