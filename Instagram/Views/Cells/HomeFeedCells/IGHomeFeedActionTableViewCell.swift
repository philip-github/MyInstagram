//
//  IGHomeFeedActionTableViewCell.swift
//  Instagram
//
//  Created by Philip Twal on 8/21/22.
//

import UIKit

protocol IGHomeFeedActionTableViewCellDelegate: AnyObject {
    func didTapLikeButton(with model: HomeRenderViewModel, position: Int)
    func didTapCommentButton(with model: HomeRenderViewModel, position: Int)
    func didTapShareButton(with model: HomeRenderViewModel, position: Int)
}

class IGHomeFeedActionTableViewCell: UITableViewCell {
    
    private struct Constants {
        static let heartImage = UIImage(systemName: "heart")
        static let heartFillImage = UIImage(systemName: "heart.fill")
    }
    
    static let identifier = "IGHomeFeedActionTableViewCell"
    
    weak var delegate: IGHomeFeedActionTableViewCellDelegate?
    
    private var model: HomeRenderViewModel?
    
    private var position: Int?
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.tintColor = .label
        return button
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.tintColor = .label
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.tintColor = .label
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemBackground
        contentView.clipsToBounds = true
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(shareButton)
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
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
        likeButton.setBackgroundImage(Constants.heartImage, for: .normal)
        likeButton.tintColor = .label
    }
    
    
    private func configureSubviews(){
        likeButton.frame = CGRect(x: contentView.left + 20,
                                  y: contentView.height/2 - ((contentView.height - 20)/2)/2,
                                  width: (contentView.height - 20)/2,
                                  height: (contentView.height - 20)/2)
        likeButton.layer.cornerRadius = likeButton.height/2
        
        
        commentButton.frame = CGRect(x: likeButton.right + 15,
                                     y: contentView.height/2 - ((contentView.height - 20)/2)/2,
                                     width: (contentView.height - 20)/2,
                                     height: (contentView.height - 20)/2)
        commentButton.layer.cornerRadius = likeButton.height/2
        commentButton.setBackgroundImage(UIImage(systemName: "message"), for: .normal)
        
        
        shareButton.frame = CGRect(x: commentButton.right + 15,
                                     y: contentView.height/2 - ((contentView.height - 20)/2)/2,
                                     width: (contentView.height - 20)/2,
                                     height: (contentView.height - 20)/2)
        shareButton.layer.cornerRadius = likeButton.height/2
        shareButton.setBackgroundImage(UIImage(systemName: "paperplane"), for: .normal)
    }
    
    @objc private func likeButtonTapped(){
        guard var myModel = model, let modelPosition = position else { return }
        switch myModel.action.renderType{
        case .actions(let action):
            if action == nil {
                myModel.action.renderType = PostRenderType.actions(provider: .like)
                likeButton.setBackgroundImage(Constants.heartFillImage, for: .normal)
                likeButton.tintColor = .systemRed
            }else if action == .like {
                myModel.action.renderType = PostRenderType.actions(provider: .unlike)
                likeButton.setBackgroundImage(Constants.heartImage, for: .normal)
            }else{
                myModel.action.renderType = PostRenderType.actions(provider: .like)
                likeButton.setBackgroundImage(Constants.heartFillImage, for: .normal)
                likeButton.tintColor = .systemRed
            }
        case .header, .primaryContent, .comments:
            break
        }
        
        delegate?.didTapLikeButton(with: myModel, position: modelPosition)
    }
    
    @objc private func commentButtonTapped(){
        guard let myModel = model, let modelPosition = position else { return }
        delegate?.didTapCommentButton(with: myModel, position: modelPosition)
    }
    
    @objc private func shareButtonTapped(){
        guard let myModel = model, let modelPosition = position else { return }
        delegate?.didTapShareButton(with: myModel, position: modelPosition)
    }
    
    func configure(with model: HomeRenderViewModel, position: Int) {
        self.model = model
        self.position = position
        switch model.action.renderType{
        case .actions(provider: .like):
            likeButton.setBackgroundImage(Constants.heartFillImage, for: .normal)
            likeButton.tintColor = .systemRed
        case .actions(provider: .unlike):
            likeButton.setBackgroundImage(Constants.heartImage, for: .normal)
        case .comments, .primaryContent, .header, .actions(provider: .none), .actions(provider: .some(.comment)), .actions(provider: .some(.share)):
            break
        }
    }
}
