//
//  EmailValidator.swift
//  ReactiveValidationRxSwift
//
//  Created by Alfian Losari on 2/17/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import Foundation

struct EmailValidator: Validator {
    
    func validate(name: String, value: Any?) throws {
        guard let text = value as? String else {
            throw ValidationError.blank(name: name)
        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        guard emailTest.evaluate(with: text) else {
            throw ValidationError.emailNotValid
        }
    }
    
}
