//
//  Extensions.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/21/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import Foundation

// Hide keyboard when tap outside of it
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// Date formatter extensions
extension DateFormatter {
    static var veryLongStringDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = ISO_LONG_FORMAT
        return dateFormatter
    }()
    
    static var longStringDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = LONG_FORMAT
        return dateFormatter
    }()
    
    static var medStringDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = MED_FORMAT
        return dateFormatter
    }()
    
    static var shortStringDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = SHORT_FORMAT
        return dateFormatter
    }()
    
    static var numberDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYYMMdd"
        return dateFormatter
    }()
}

// Date extension members for computing the calendar view of the app
extension Date
{
    // What is the date of the start of this week?
    var startOfWeek: Date? {
        return Calendar.gregorian.date(from: Calendar.gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
    }
    
    // What was the date 3 weeks ago Sunday?
    var threeWeeksAgoSunday: Date? {
        return Calendar.gregorian.date(byAdding: .weekOfYear, value: -3, to: self.startOfWeek!)
    }
}

extension Calendar {
    static let gregorian = Calendar(identifier: .gregorian)
}

