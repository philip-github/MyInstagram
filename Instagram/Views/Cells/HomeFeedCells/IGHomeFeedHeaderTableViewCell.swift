//
//  IGHomeFeedHeaderTableViewCell.swift
//  Instagram
//
//  Created by Philip Twal on 8/21/22.
//

import UIKit

protocol IGHomeFeedHeaderTableViewCellDelegate: AnyObject {
    func didTapMoreButton(with model: UserPost)
}

class IGHomeFeedHeaderTableViewCell: UITableViewCell {
    
    static let identifier = "IGHomeFeedHeaderTableViewCell"
    private var model: UserPost?
    weak var delegate: IGHomeFeedHeaderTableViewCellDelegate?
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(systemName: "person.circle")
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.layer.masksToBounds = true
        button.tintColor = .label
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemBackground
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(moreButton)
        moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configureSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        nameLabel.text = nil
        model = nil
    }
    
    private func configureSubviews(){
        profileImageView.frame = CGRect(x: contentView.left + 5,
                                        y: contentView.height/2 - (contentView.height - 15)/2,
                                        width: contentView.height - 15,
                                        height: contentView.height - 15)
        profileImageView.layer.cornerRadius = profileImageView.height/2
        profileImageView.layer.borderWidth = 1.0
        profileImageView.layer.borderColor = UIColor.secondaryLabel.cgColor
        
        
        nameLabel.frame = CGRect(x: profileImageView.right + 10,
                                 y: contentView.height/2 - (contentView.height - (contentView.height - 5)/2)/2,
                                 width: contentView.width/2,
                                 height: contentView.height - (contentView.height - 5)/2)
        
        moreButton.frame = CGRect(x: contentView.right - 50,
                                  y: contentView.height/2 - (10/2),
                                  width: 30,
                                  height: 10)
    }
    
    @objc private func moreButtonTapped(){
        guard let myModel = model  else { return }
        delegate?.didTapMoreButton(with: myModel)
    }
    
    func configure(with model: UserPost){
        self.model = model
        self.nameLabel.text = model.user.username
        self.profileImageView.loadImage(with: model.user.profilePhoto)
    }
}
