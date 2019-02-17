//
//  Validator.swift
//  ReactiveValidationRxSwift
//
//  Created by Alfian Losari on 2/17/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import Foundation

protocol Validator {
    func validate(name: String, value: Any?) throws
}
