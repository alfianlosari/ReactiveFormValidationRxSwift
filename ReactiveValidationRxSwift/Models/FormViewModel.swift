//
//  Form.swift
//  ReactiveValidationRxSwift
//
//  Created by Alfian Losari on 2/17/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import Foundation
import RxSwift

class FormViewModel {
    
    let disposeBag = DisposeBag()
    
    let sections: [FormSection]
    public private(set) var isValid = Variable(false)
    
    init(sections: [FormSection]) {
        self.sections = sections
        let fieldIsValidObservables = sections
            .flatMap { $0.fields }
            .map { $0.isValid.asObservable() }
        
        Observable
            .combineLatest(fieldIsValidObservables)
            .subscribe { [weak self] (event) in
                let values = event.element ?? []
                print(values)
                self?.isValid.value = values.firstIndex { !$0 } == nil }
            .disposed(by: disposeBag)
      
    }

}

class FormSection {
    var headerTitle: String?
    var footerTitle: String?
    var fields: [FormFieldViewModel]
    
    init(headerTitle: String?, footerTitle: String?, fields: [FormFieldViewModel]) {
        self.headerTitle = headerTitle
        self.footerTitle = footerTitle
        self.fields = fields
    }
}

extension FormViewModel {
    
    static var personalForm: FormViewModel {
        return FormViewModel(sections: [
            FormSection(headerTitle: "Personal Information", footerTitle: "Please fill all your personal information in this section", fields: [
                FormFieldViewModel(name: "First Name", value: nil, type: .textField(placeholder: "Enter first name"), validator: NameValidator()),
                FormFieldViewModel(name: "Last Name", value: nil, type: .textField(placeholder: "Enter last name"), validator: NameValidator()),
                FormFieldViewModel(name: "Birthdate", value: nil, type: .datePicker(formatter: Utility.formatter, datePickerMode: .date), validator: BirthDateValidator())
                ]),
            FormSection(headerTitle: "Contact Information", footerTitle: "This information will be used to contact you", fields: [
                FormFieldViewModel(name: "Email", value: nil, type: .textField(placeholder: "Enter email"), validator: EmailValidator()),
                FormFieldViewModel(name: "Mobile", value: nil, type: .textField(placeholder: "Enter mobile"), validator: MobileNumberValidator())
                ])
            ])
        
    }
    
}
