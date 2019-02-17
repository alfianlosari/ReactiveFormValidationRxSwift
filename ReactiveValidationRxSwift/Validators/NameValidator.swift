//
//  NameValidator.swift
//  ReactiveValidationRxSwift
//
//  Created by Alfian Losari on 2/17/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import Foundation

struct NameValidator: Validator {
    
    private let maxChar = 15
    private let minChar = 3
    
    func validate(name: String, value: Any?) throws {
        guard let text = value as? String else {
            throw ValidationError.blank(name: name)
        }
        
        guard text.count > minChar else {
            throw ValidationError.nameTooShort(name: name, minCharacters: minChar)
        }
        
        guard text.count < maxChar else {
            throw ValidationError.nameTooLong(name: name, maxCharacters: maxChar)
        }
    }
    
}
