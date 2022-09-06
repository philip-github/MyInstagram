//
//  NotificationsFollowEventTableViewCell.swift
//  Instagram
//
//  Created by Philip Twal on 9/1/22.
//

import UIKit

protocol NotificationsFollowEventTableViewCellDelegate: AnyObject {
    func didTapFollowUnFollowButton(with model: UserNotification)
}

class NotificationsFollowEventTableViewCell: UITableViewCell {
    
    static let identifier = "NotificationsFollowEventTableViewCell"
    
    weak var delegate: NotificationsFollowEventTableViewCellDelegate?
    
    private var model: UserNotification?
    
    private let profileImageView: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.borderWidth = 1.0
        image.layer.borderColor = UIColor.secondaryLabel.cgColor
        return image
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.backgroundColor = .link
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(label)
        contentView.addSubview(followButton)
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureSubViews()
    }
    
    private func configureSubViews(){
        profileImageView.frame = CGRect(x: contentView.left + 10,
                                        y: contentView.height/2 - (contentView.height/1.5)/2,
                                        width: contentView.height/1.5,
                                        height: contentView.height/1.5)
        profileImageView.layer.cornerRadius = profileImageView.height/2
        profileImageView.layer.borderWidth = 1.0
        profileImageView.layer.borderColor = UIColor.secondaryLabel.cgColor
        
        label.frame = CGRect(x: profileImageView.right + 5,
                             y: ((contentView.height - 4)/2) - (contentView.height - 4)/2,
                             width: (contentView.width - contentView.height/1.5) - (contentView.height - 5),
                             height: contentView.height - 4)
        label.adjustsFontSizeToFitWidth = true
        
        followButton.frame = CGRect(x: contentView.right - contentView.height - 4,
                                  y: contentView.height/2 - (contentView.height/3)/2,
                                  width: contentView.height - 5,
                                  height: contentView.height/3)
        followButton.layer.borderWidth = 1.0
        followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
        followButton.layer.cornerRadius = 5.0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        label.text = nil
        followButton.setTitle(nil, for: .normal)
    }
    
    @objc private func didTapFollowButton(){
        guard let myModel = model else { return }
        delegate?.didTapFollowUnFollowButton(with: myModel)
    }
    
    func configure(with model: UserNotification) {
        self.model = model
        switch model.type {
        case .like(_):
            break
        case .follow(let state):
            switch state{
            case .following:
                followButton.setTitle("Follow", for: .normal)
            case .un_following:
                followButton.setTitle("Unfollow", for: .normal)
            }
        }
        profileImageView.loadImage(with: model.user.profilePhoto)
        label.text = model.text
    }
}
