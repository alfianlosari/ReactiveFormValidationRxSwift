//
//  MobileNumberValidator.swift
//  ReactiveValidationRxSwift
//
//  Created by Alfian Losari on 2/17/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import Foundation

struct MobileNumberValidator: Validator {
    
    func validate(name: String, value: Any?) throws {
        
        guard let text = value as? String else {
            throw ValidationError.blank(name: name)
        }
        
        let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
        let inputString = text.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        guard text == filtered else {
            throw ValidationError.invalidMobileNumber
        }
        
    }
}
