//
//  FormViewController.swift
//  ReactiveValidationRxSwift
//
//  Created by Alfian Losari on 2/17/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FormViewController: UITableViewController {
   
    @IBOutlet weak var saveButtonItem: UIBarButtonItem!
    
    let form = FormViewModel.personalForm
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form.isValid
            .asObservable()
            .bind(to: saveButtonItem.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return form.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return form.sections[section].fields.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let field = form.sections[indexPath.section].fields[indexPath.row]
        switch field.type {
        case .textField:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as! FormTextFieldTableViewCell
            cell.setup(with: field)
            return cell
            
        case .datePicker:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DatePickerCell", for: indexPath) as! FormDatePickerTableViewCell
            cell.setup(with: field)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return form.sections[section].headerTitle
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return form.sections[section].footerTitle
    }

}
