//
//  ProfileTabsCollectionReusableView.swift
//  Instagram
//
//  Created by Philip Twal on 8/23/22.
//

import UIKit
 
protocol ProfileTabsCollectionReusableViewDelegate: AnyObject {
    func didTapGridButton(for cell: ProfileTabsCollectionReusableView)
    func didTapTaggedButton(for cell: ProfileTabsCollectionReusableView)
}
 
class ProfileTabsCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "ProfileTabsCollectionReusableView"
    
    public weak var delegate: ProfileTabsCollectionReusableViewDelegate?
    
    private let gridButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .label
        button.setBackgroundImage(UIImage(systemName: "circle.grid.3x3.circle"), for: .normal)
        return button
    }()
    
    private let taggedButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .secondaryLabel
        button.setBackgroundImage(UIImage(systemName: "tag.circle"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        addSubview(gridButton)
        addSubview(taggedButton)
        addButtonsActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureButtons()
    }
    
    private func configureButtons(){
        let halfSize = (width - 4)/2
        
        //MARK: Grid Button Configuration
        gridButton.frame = CGRect(x: (halfSize - (height - 4)/2) - (halfSize - (height - 4)/2)/2,
                                  y: 2,
                                  width: height-4,
                                  height: height-4).integral
        gridButton.layer.cornerRadius = gridButton.height/2
        
        //MARK: Tagged Button Configuration
        taggedButton.frame = CGRect(x: (halfSize - (height - 4)/2) + (halfSize - (height - 4)/2)/2,
                                    y: 2,
                                    width: height-4,
                                    height: height-4).integral
        taggedButton.layer.cornerRadius = taggedButton.height/2
    }
    
    private func addButtonsActions(){
        gridButton.addTarget(self, action: #selector(gridButtonTapped), for: .touchUpInside)
        taggedButton.addTarget(self, action: #selector(taggedButtonTapped), for: .touchUpInside)
    }
    
    @objc private func gridButtonTapped(){
        gridButton.tintColor = .label
        taggedButton.tintColor = .secondaryLabel
        delegate?.didTapGridButton(for: self)
    }
    
    @objc private func taggedButtonTapped(){
        gridButton.tintColor = .secondaryLabel
        taggedButton.tintColor = .label
        delegate?.didTapTaggedButton(for: self)
    }
}
