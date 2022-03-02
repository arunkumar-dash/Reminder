//
//  AppLoginViewControllerContract.swift
//  Reminder
//
//  Created by Arun Kumar on 23/02/22.
//

import Foundation
import AppKit

protocol AppLoginViewControllerContract: NSViewController {
    func createUser(_ sender: RegistrationView)
    
    func changeViewToRegistration()
    
    func changeViewToLogin()
    
    func changeViewToSwitchUser()
    
    func navigateBackToPreviousView()
    
    func getAvailableUsers() -> [User]
    
    func getLastLoggedInUser() -> User?
    
    func setLastLoggedInUser(user: User)
    
}
