//
//  PhotoCollectionViewCell.swift
//  Instagram
//
//  Created by Philip Twal on 8/23/22.
//
import AVFoundation
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PhotoCollectionViewCell"
    
    private var player: AVPlayer?
    private var playerLayer = AVPlayerLayer()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.addSublayer(playerLayer)
        contentView.addSubview(imageView)
        contentView.layer.masksToBounds = true
        contentView.clipsToBounds = true
        contentView.backgroundColor = .secondarySystemBackground
        accessibilityLabel = "User post image"
        accessibilityHint = "Tap to open post image"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = contentView.bounds
        imageView.frame = contentView.bounds
    }
    
    public func configure(with model: UserPost){
        switch model.postType{
        case .photo:
            let url = model.thumbnailImage
            imageView.loadImage(with: url)
        case .video:
            let player = AVPlayer(url: model.postURL)
            playerLayer.player = player
            playerLayer.player?.volume = 0
            playerLayer.player?.play()
        }
    }
}
