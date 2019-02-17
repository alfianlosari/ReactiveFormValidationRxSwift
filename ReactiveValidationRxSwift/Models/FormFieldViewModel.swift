//
//  FormField.swift
//  ReactiveValidationRxSwift
//
//  Created by Alfian Losari on 2/17/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import Foundation
import RxSwift

class FormFieldViewModel {
    
    private let disposeBag = DisposeBag()
    
    var name: String
    var _value: Variable<Any?> = Variable(nil)
    var value: Any? {
        set {
            _value.value = newValue
        }
        
        get {
            return _value.value
        }
    }
        
    var type: FormFieldType
    var errorValidateInfo: String? = nil
    var validator: Validator?
    var isValid = Variable(false)
    
    var textValue: String? {
        guard let value = value else {
            return nil
        }
        return "\(value)"
    }
    
    init(name: String, value: Any?, type: FormFieldType, validator: Validator?) {
        self.name = name
        self._value.value = value
        self.type = type
        self.validator = validator
        
        self._value
            .asObservable()
            .subscribe { [weak self] (event) in
                do {
                    try self?.validate()
                    self?.isValid.value = true
                } catch {
                    self?.isValid.value = false
                }}
            .disposed(by: disposeBag)
    }
    
    func validate() throws {
        errorValidateInfo = nil

        if let validator = validator  {
            do {
                try validator.validate(name: name, value: value)
            } catch {
                errorValidateInfo = error.localizedDescription
                throw error
            }
        }
    }
}
