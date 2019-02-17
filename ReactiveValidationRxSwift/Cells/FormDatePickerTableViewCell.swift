//
//  FormDatePickerTableViewCell.swift
//  ReactiveValidationRxSwift
//
//  Created by Alfian Losari on 2/17/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FormDatePickerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var infoLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    private var field: FormFieldViewModel?
    private var isDisplayingDatePicker = Variable(false)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(cellDidTapped(_:)))
        contentView.addGestureRecognizer(tapGR)
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        updateDatePickerDisplay()
    }
    
    func setup(with field: FormFieldViewModel) {
        self.field = field
        
        nameLabel.text = field.name
        if case .datePicker(_, let mode) = field.type {
            datePicker.datePickerMode = mode
        }
     
        field._value
            .asObservable()
            .subscribe { [weak self] (_) in
                self?.updateUI()
                
        }.disposed(by: disposeBag)
        
        isDisplayingDatePicker
            .asObservable()
            .subscribe { [weak self](_) in
                self?.updateUI()
        }.disposed(by: disposeBag)
    
    }
    
    private func updateUI() {
        updateInfoLabel()
        updateValueLabel()
        updateDatePickerDisplay()
        updateClearButton()
        tableView?.beginUpdates()
        tableView?.endUpdates()
    }
    
    @objc private func cellDidTapped(_ sender: Any) {
        isDisplayingDatePicker.value = !self.isDisplayingDatePicker.value
        if isDisplayingDatePicker.value && field?.value == nil {
            datePicker.date = Date()
            self.dateChanged(datePicker)
        }
    }
    
    @objc private func dateChanged(_ sender: UIDatePicker) {
        guard let field = field else {
            return
        }
        field.value = sender.date
    }
    
    private func updateInfoLabel() {
        if let info = field?.errorValidateInfo, !info.isEmpty, let _ = field?.value {
            infoLabel.text = info
            infoLabel.isHidden = false
        } else {
            infoLabel.isHidden = true
        }
    }
    
    private func updateValueLabel() {
        guard let field = field else {
            return
        }
        
        if let date = field.value as? Date, case .datePicker(let formatter, _) = field.type {
            valueLabel.text = formatter.string(from: date)
            datePicker.date = date
        } else {
            valueLabel.text = "Select \(field.name)"
        }
    }
    
    private func updateClearButton() {
        let isFieldValueExists = field?.value != nil
        self.clearButton.isHidden = !isFieldValueExists
    }
    
    private func updateDatePickerDisplay() {
        self.datePicker.isHidden = !isDisplayingDatePicker.value
    }

    @IBAction func clearTapped(_ sender: Any) {
        guard let field = field else {
            return
        }
        field.value = nil
        isDisplayingDatePicker.value = false
    }
    
}
