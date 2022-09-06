//
//  IGHomeFeedGeneralTableViewCell.swift
//  Instagram
//
//  Created by Philip Twal on 8/21/22.
//

import UIKit

class IGHomeFeedGeneralTableViewCell: UITableViewCell {

    static let identifier = "IGHomeFeedGeneralTableViewCell"
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemBackground
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
