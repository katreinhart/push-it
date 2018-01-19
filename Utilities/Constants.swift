//
//  Constants.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/19/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

// URL Constants
let BASE_URL = "https://localhost:8080/"
let REGISTER_URL = "\(BASE_URL)/auth/register"
let LOGIN_URL = "\(BASE_URL)/auth/login"

// Segues

let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

// Headers
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]
//let BEARER_HEADER = [
  //  "authorization": "Bearer \(AuthService.instance.authToken)",
  //  "Content-Type": "application/json; charset=utf-8"
//]
