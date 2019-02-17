//
//  ValidationError.swift
//  ReactiveValidationRxSwift
//
//  Created by Alfian Losari on 2/17/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import Foundation

enum ValidationError: Error, LocalizedError {
    
    case nameTooShort(name: String, minCharacters: Int)
    case nameTooLong(name: String, maxCharacters: Int)
    case emailNotValid
    case invalidValueType
    case invalidMobileNumber
    case dateTooEarlier(name: String)
    case dateTooLate(name: String)
    case blank(name: String)
    
    var errorDescription: String? {
        return localizedDescription
    }
    
    var localizedDescription: String {
        switch self {
        case .nameTooShort(let name, let min):
            return "\(name) must be at least \(min) characters."
        case .nameTooLong(let name, let max):
            return "\(name) must not exceed \(max) characters."
        case .emailNotValid:
            return "Email is not valid"
        case .blank(let name):
            return "\(name) must be filled"
        case .invalidValueType:
            return "Invalid value type passed"
        case .dateTooEarlier(let name):
            return "The \(name) must be later"
        case .dateTooLate(let name):
            return "The \(name) must be earlier"
        case .invalidMobileNumber:
            return "Mobile Number is not valid"
        }
        
    }
}
