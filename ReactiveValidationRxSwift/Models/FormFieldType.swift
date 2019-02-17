//
//  FormFieldType.swift
//  ReactiveValidationRxSwift
//
//  Created by Alfian Losari on 2/17/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import Foundation
import UIKit

enum FormFieldType {
    
    case textField(placeholder: String?)
    case datePicker(formatter: DateFormatter, datePickerMode: UIDatePicker.Mode)
}
