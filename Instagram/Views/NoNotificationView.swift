//
//  NoNotificationView.swift
//  Instagram
//
//  Created by Philip Twal on 9/1/22.
//

import UIKit

class NoNotificationView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bell")
        imageView.tintColor = .secondaryLabel
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "No Notifications Yet !"
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: (self.width/2) - ((self.width - 10)/4)/2,
                                 y: 0,
                                 width: (self.width - 10)/4,
                                 height: (self.width - 10)/4)
        
        label.frame = CGRect(x: (self.width/2) - (self.width/2)/2,
                             y: imageView.bottom,
                             width: self.width/2,
                             height: self.width/4)
    }
}
