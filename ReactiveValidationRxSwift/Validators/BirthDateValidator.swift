//
//  BirthDateValidator.swift
//  ReactiveValidationRxSwift
//
//  Created by Alfian Losari on 2/17/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import Foundation

struct BirthDateValidator: Validator {
    
    func validate(name: String, value: Any?) throws {
        guard let date = value as? Date else {
            throw ValidationError.blank(name: name)
        }
        
        let today = Date()
        
        guard date <= today else {
            throw ValidationError.dateTooLate(name: name)
        }
        
        let todayYear = Calendar.current.component(.year, from: today)
        let selectedDateYear = Calendar.current.component(.year, from: date)
        let oneHundredYearsAgo = todayYear - 100
        
        guard selectedDateYear > oneHundredYearsAgo else {
            throw ValidationError.dateTooEarlier(name: name)
        }
    }
    
}

