//
//  AppLoginPresenterContract.swift
//  Reminder
//
//  Created by Arun Kumar on 25/02/22.
//

import Foundation
import AppKit

protocol AppLoginPresenterContract {
    var appLoginViewController: AppLoginViewControllerContract? { get set }
    
    func createUser(username: String, password: String, image: NSImage?, onSuccess success: () -> Void, onFailure failure: (String) -> Void)
    
    func getAvailableUsers() -> [User]
    
    func getLastLoggedInUser() -> User?
    
    func setLastLoggedInUser(user: User)
}
