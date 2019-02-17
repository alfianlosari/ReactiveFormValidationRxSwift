//
//  UITableViewCell+Extension.swift
//  ReactiveValidationRxSwift
//
//  Created by Alfian Losari on 2/17/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import UIKit

extension UIView {
    func parentView<T: UIView>(of type: T.Type) -> T? {
        guard let view = self.superview else {
            return nil
        }
        return (view as? T) ?? view.parentView(of: T.self)
    }
}

extension UITableViewCell {
    var tableView: UITableView? {
        return self.parentView(of: UITableView.self)
    }
}
