//
//  Constants.swift
//  PUSH_IT
//
//  Created by Katherine Reinhart on 1/19/18.
//  Copyright © 2018 reinhart.digital. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

// Date format strings
let ISO_LONG_FORMAT = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
let LONG_FORMAT = "yyyy-MM-dd HH:mm:ss"
let MED_FORMAT = "MMM dd, yyyy"
let SHORT_FORMAT = "MM/dd/yy"

// URL Constants
let BASE_URL = "https://push-it-api.herokuapp.com"
let REGISTER_URL = "\(BASE_URL)/auth/register"
let LOGIN_URL = "\(BASE_URL)/auth/login"
let SET_INFO_URL = "\(BASE_URL)/api/setinfo"
let SECONDARY_GOALS_URL = "\(BASE_URL)/api/user/goals"
let FETCH_EXERCISES_URL = "\(BASE_URL)/api/exercises"
let UPDATE_PRIMARY_GOAL_URL = "\(BASE_URL)/api/user/primarygoal"
let CREATE_WORKOUT_URL = "\(BASE_URL)/api/workouts"
let HISTORY_URL = "\(BASE_URL)/api/history"

// Segues

let TO_LOGIN = "toLogin"
let TO_REGISTER = "toRegister"
let SHOW_ONBOARDING = "showOnboarding"
let SHOW_DASHBOARD_FROM_ONBOARDING = "showDashboardFromOnboarding"
let SHOW_DASHBOARD_FROM_SIGNIN = "showDashboardFromSignIn"
let SHOW_SW_REVEAL = "showSWReveal"
let SHOW_SPLASH = "showSplashScreen"
let SHOW_DASHBOARD_FROM_MENU = "showDashboardFromMenu"
let SHOW_SW_REVEAL_FROM_ONBOARDING = "showSWRevealFromOnboarding"
let SHOW_EDIT_GOAL_VC = "showEditGoalVC"
let UNWIND_TO_GOALS = "unwindSegueToGoalsVC"
let SHOW_START_NEW_WORKOUT_VC = "showStartNewWorkoutVC"
let SHOW_GOALS_FROM_MENU = "ShowGoalsFromMenu"
let SHOW_WORKOUT_FROM_MENU = "ShowWorkoutFromMenu"
let START_WORKOUT_FROM_BUILDER = "StartPerformWorkoutFromWorkoutBuilder"
let UNWIND_TO_DASHBOARD = "unwindToDashboard"
let SHOW_HISTORY_FROM_DASHBOARD = "showHistoryFromDashboard"
let SHOW_HISTORY_FROM_MENU = "showHistoryFromMenu"

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"
let USER_ID = "userId"

// Headers
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]

let BEARER_HEADER = [
    "authorization": "Bearer \(AuthService.instance.authToken)",
    "Content-Type": "application/json; charset=utf-8"
]

