//
//  NotificationsLikeEventTableViewCell.swift
//  Instagram
//
//  Created by Philip Twal on 9/1/22.
//

import UIKit

protocol NotificationsLikeEventTableViewCellDelegate: AnyObject {
    func didTapPostButton(with model: UserNotification)
}

class NotificationsLikeEventTableViewCell: UITableViewCell {
    
    static let identifier = "NotificationsLikeEventTableViewCell"
    
    weak var delegate: NotificationsLikeEventTableViewCellDelegate?
    
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
    
    private let postButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        let imageView = UIImageView()
        button.addSubview(imageView)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(label)
        contentView.addSubview(postButton)
        postButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureSubViews()
        configurePostButtonWithImage()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        label.text = nil
    }
    
    @objc private func didTapPostButton(){
        guard let myModel = model else { return }
        delegate?.didTapPostButton(with: myModel)
    }
    
    private func configurePostButtonWithImage(){
        guard let postButtonImageView = postButton.subviews.first as? UIImageView else { return }
        postButtonImageView.frame = postButton.bounds
        postButtonImageView.layer.masksToBounds = true
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
        
        postButton.frame = CGRect(x: contentView.right - contentView.height - 4,
                                  y: contentView.height/2 - (contentView.height/1.5)/2,
                                  width: contentView.height/1.5,
                                  height: contentView.height/1.5)
        postButton.layer.borderWidth = 1.0
        postButton.layer.borderColor = UIColor.secondaryLabel.cgColor
        postButton.layer.cornerRadius = 5.0
    }
    
    func configure(with model: UserNotification){
        self.model = model
        switch model.type{
        case .like(let post):
            let thumbnail = post.thumbnailImage
            guard let postImageView = postButton.subviews.first as? UIImageView else { return }
            postImageView.loadImage(with: thumbnail)
        case .follow:
            break
        }
        profileImageView.loadImage(with: model.user.profilePhoto)
        label.text = model.text
    }
}
