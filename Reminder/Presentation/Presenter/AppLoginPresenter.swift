//
//  AppLoginPresenter.swift
//  Reminder
//
//  Created by Arun Kumar on 23/02/22.
//

import Foundation
import AppKit

public class AppLoginPresenter: AppLoginPresenterContract {
    weak var appLoginViewController: AppLoginViewControllerContract?
    
    func createUser(username: String, password: String, image: NSImage?, onSuccess success: () -> Void, onFailure failure: (String) -> Void) {
        
        createUserUseCase(username: username, password: password, image: image, onSuccess: success, onFailure: failure)
    }
    
    func getAvailableUsers() -> [User] {
        return getAvailableUsersFromDatabase()
    }
    
    func getLastLoggedInUser() -> User? {
        return getLastLoggedInUserFromDatabase()
    }
    
    func setLastLoggedInUser(user: User) {
        setLastLoggedInUserToDatabase(user: user)
    }
    
    // use case methods below
//    private var userDatabase: [String: (username: String, password: String, image: NSImage?)] = [:]
    private var userDatabase: [String: (username: String, password: String, image: NSImage?)] = ["user1":(username: "user1", password: "popop", image: NSImage(named: "dp"))]
    private func createUserUseCase(username: String, password: String, image: NSImage?, onSuccess successMethod: () -> Void, onFailure failureMethod: (_ message: String) -> Void) {
        
        if isUserExists(username: username) {
            let message = "User name taken"
            failureMethod(message)
        } else if addToDatabase(username: username, password: password, image: image) {
            successMethod()
        } else {
            let message = "Error adding account to database"
            failureMethod(message)
        }
        
    }
    
    private func isUserExists(username: String) -> Bool {
        if userDatabase.keys.contains(username) {
            return true
        }
        return false
    }
    
    private func addToDatabase(username: String, password: String, image: NSImage?) -> Bool {
        userDatabase[username] = (username, password, image)
        return true
    }
    
    
    private var availableUsersList: [User] = []
    
    private func getAvailableUsersFromDatabase() -> [User] {
        availableUsersList = []
        for user in userDatabase.values {
            let user = User(username: user.username, password: user.password, image: user.image)
            availableUsersList.append(user)
        }
        return availableUsersList
    }
    
    private var lastLoggedInUser: User? = nil
//    private var lastLoggedInUser: User? = User(username: "Abc bca", password: "pass123")

    
    private func getLastLoggedInUserFromDatabase() -> User? {
        return lastLoggedInUser
    }
    
    private func setLastLoggedInUserToDatabase(user: User) {
        lastLoggedInUser = user
    }
        
    // use case methods above
}
