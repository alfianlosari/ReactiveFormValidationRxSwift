//
//  FormTextFieldTableViewCell.swift
//  ReactiveValidationRxSwift
//
//  Created by Alfian Losari on 2/17/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FormTextFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    var field: FormFieldViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }
    
    func setup(with field: FormFieldViewModel) {
        self.field = field
        
        nameLabel.text = field.name
        textField.text = field.textValue
        if case .textField(let placeholder) = field.type {
            textField.placeholder = placeholder
        }
        
        updateInfoLabel()
    }
    
    private func updateInfoLabel() {
        if let info = field?.errorValidateInfo, !info.isEmpty, let value = field?.textValue, !value.isEmpty {
            infoLabel.text = info
            infoLabel.isHidden = false
        } else {
            infoLabel.isHidden = true
        }
    }
}


extension FormTextFieldTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        field?.errorValidateInfo = nil
        updateInfoLabel()
        tableView?.beginUpdates()
        tableView?.endUpdates()
        return true
    }
 
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let field = field else {
            return true
        }
        
        if let textFieldString = textField.text, let swtRange = Range(range, in: textFieldString) {
            let fullString = textFieldString.replacingCharacters(in: swtRange, with: string)
            field.value = fullString
        }
        
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        updateInfoLabel()
        tableView?.beginUpdates()
        tableView?.endUpdates()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
