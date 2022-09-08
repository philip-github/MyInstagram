//
//  IGHomeFeedTableViewCell.swift
//  Instagram
//
//  Created by Philip Twal on 8/21/22.
//
import AVFoundation
import UIKit

class IGHomeFeedTableViewCell: UITableViewCell {
    
    static let identifier = "IGHomeFeedTableViewCell"
    
    private let postImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var model: UserPost?
    
    private var player: AVPlayer?
    private var playerLayer = AVPlayerLayer()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemBackground
        contentView.clipsToBounds = true
        contentView.layer.masksToBounds = true
        contentView.layer.addSublayer(playerLayer)
        contentView.addSubview(postImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureSubviews()
    }
    
    private func configureSubviews(){
        playerLayer.frame = contentView.bounds
        postImageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
        player = nil
    }
    
    func configure(with model: UserPost) {
        switch model.postType {
        case .photo:
            postImageView.loadImage(with: URL(string: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg")!)
        case .video:
            player = AVPlayer(url: model.postURL)
            playerLayer.player = player
            playerLayer.player?.volume = 0
            playerLayer.player?.play()
        }
    }
}
