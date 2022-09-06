//
//  PhotoCollectionViewCell.swift
//  Instagram
//
//  Created by Philip Twal on 8/23/22.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PhotoCollectionViewCell"
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
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
        imageView.frame = contentView.bounds
    }
    
    public func configure(with model: UserPost){
        let url = model.thumbnailImage
        imageView.loadImage(with: url)
    }
    
    public func configure(debug imageName: String){
        imageView.image = UIImage(named: imageName)
    }
}
