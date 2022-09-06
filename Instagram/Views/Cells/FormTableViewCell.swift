//
//  FormTableViewCell.swift
//  Instagram
//
//  Created by Philip Twal on 8/22/22.
//

import UIKit
import SwiftUI

protocol FormTableViewCellDelegate: AnyObject {
    func formTableViewCell(for cell: FormTableViewCell, with model: ProfileEditModel)
}

class FormTableViewCell: UITableViewCell {
    
    static let identifier = "FormTableViewCell"
    
    public weak var delegate: FormTableViewCellDelegate?
    
    private var model: ProfileEditModel?
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .label
        return label
    }()
    
    private let field: UITextField = {
        let field = UITextField()
        field.textColor = .label
        field.returnKeyType = .done
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.adjustsFontSizeToFitWidth = true
        return field
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(label)
        contentView.addSubview(field)
        field.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = CGRect(x: 5,
                             y: 0,
                             width: contentView.width/3.0,
                             height: contentView.height)
        
        field.frame = CGRect(x: label.right + 5,
                             y: 0,
                             width: contentView.width - 10 - label.width,
                             height: contentView.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        field.placeholder = nil
        field.text = nil
    }
    
    public func configure(model: ProfileEditModel){
        self.model = model
        label.text = model.label
        field.placeholder = model.placeholder
        field.text = model.value
    }
}


extension FormTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard var model = model else { return true }
        model.value = textField.text
        delegate?.formTableViewCell(for: self, with: model)
        textField.resignFirstResponder()
        return true
    }
}
