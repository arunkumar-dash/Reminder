//
//  SwitchUserView.swift
//  Reminder
//
//  Created by Arun Kumar on 18/02/22.
//

import Foundation
import AppKit

class SwitchUserView: NSView {
    var userViews: [NSView] = []
    var currentUser: User?
    var parentViewController: AppLoginViewController?
    
    func load(_ viewController: AppLoginViewController) {
        parentViewController = viewController
        
        let button = viewController.createUserButtonInSwitchUserView
        
        let selectUserLabel = NSTextField(labelWithString: "Select User")
        selectUserLabel.font = NSFont.preferredFont(forTextStyle: .title1)
        selectUserLabel.textColor = .black
        
        for (number, user) in User.getUsers().enumerated() {
            currentUser = user
            
            let userView = GetViewForUser(user: user).view()
            userView.wantsLayer = true
            if number % 2 == 0 {
                userView.layer?.backgroundColor = NSColor.systemRed.cgColor
            } else {
                userView.layer?.backgroundColor = NSColor.systemRed.cgColor
            }
            userViews.append(userView)
            
            
            let click = NSClickGestureRecognizer(target: self, action: #selector(changeLastLoggedInUser))
            userView.addGestureRecognizer(click)
        }
        
        
        let userStackView = NSStackView(views: userViews)
        userStackView.orientation = .horizontal
        
        
        
        
        button.bezelColor = .red
        
        
        
        let scrollView = NSScrollView(frame: NSRect(x: 0, y: 0, width: 300, height: 300))
        scrollView.documentView = userStackView
        userStackView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        userStackView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        subviews = [selectUserLabel, scrollView, button]
        
        
        selectUserLabel.translatesAutoresizingMaskIntoConstraints = false
        userStackView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        NSLayoutConstraint.activate([
            selectUserLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            selectUserLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            
            
            scrollView.centerXAnchor.constraint(equalTo: centerXAnchor),
            scrollView.topAnchor.constraint(equalTo: selectUserLabel.bottomAnchor, constant: 100),
            scrollView.heightAnchor.constraint(equalToConstant: 300),
            scrollView.widthAnchor.constraint(equalToConstant: 300),
            
            
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
        ])
    }
    
    @objc func changeLastLoggedInUser() {
        guard let currentUser = currentUser else {
            return
        }

        User.lastLoggedInUser = currentUser
        print("user:", currentUser.username, "was clicked")
        
        if let parentViewController = parentViewController {
            parentViewController.changeViewToLogin()
        }
    }
}

class GetViewForUser {
    let userImage: NSImage?
    let username: String
    let user: User
    
    init(user: User) {
        self.user = user
        self.userImage = user.photo
        self.username = user.username
    }
    
    func view() -> NSView {
        let defaultImage = NSImage(named: "user_icon")!
        defaultImage.size = NSSize(width: 40, height: 40)
        let userImageView = NSImageView(image: userImage ?? defaultImage)
        let usernameView = NSTextField(labelWithString: username)
        usernameView.textColor = .black
        
        let view = NSView(frame: NSRect(x: 0, y: 0, width: 300, height: 40))
        view.subviews = [userImageView, usernameView]
        
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.systemYellow.cgColor
        
        
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        usernameView.translatesAutoresizingMaskIntoConstraints = false
        
//        let click = NSClickGestureRecognizer(target: self, action: #selector(changeLastLoggedInUser))
//        view.addGestureRecognizer(click)
        
        NSLayoutConstraint.activate([
            userImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            userImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            userImageView.widthAnchor.constraint(equalToConstant: 30),
            
            usernameView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            usernameView.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor),
        ])
        
        return view
    }
    
//    @objc func changeLastLoggedInUser() {
//        User.lastLoggedInUser = user
//        print("user:", username, "was clicked")
//    }
}

class User {
    static var users: [User] = [User(username: "Username1", password: "pass"), User(username: "Username2", password: "pass2", photo: NSImage(named: "dp"))]
    static var lastLoggedInUser: User? = nil
    
    let photo: NSImage?
    let username: String
    let password: String
    init(username: String, password: String, photo: NSImage? = nil) {
        self.username = username
        self.password = password
        self.photo = photo
    }
    
    static func getUsers() -> [User] {
        return users
    }
    
    static func getLastLoggedInUser() -> User? {
        // return last user from db
        return lastLoggedInUser
    }
}
