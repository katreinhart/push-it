//
//  DateHelper.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/22/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import Foundation

var dateString = "2014-07-15" // change to your date format

var dateFormatter  = DateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd"

var date = dateFormatter.dateFromString(dateString)

