//
//  SwitchUserView.swift
//  Reminder
//
//  Created by Arun Kumar on 18/02/22.
//

import Foundation
import AppKit

class SwitchUserView: NSView {
    private var userViews: [NSView] = []
    private var currentUser: User?
    private var parentViewController: AppLoginViewController?
    
    func load(_ viewController: NSViewController) {
        guard let viewController = viewController as? AppLoginViewController else {
            return
        }
        parentViewController = viewController
        
        let button = viewController.createUserButtonInSwitchUserView
        
        let selectUserLabel = NSTextField(labelWithString: "Select User")
        selectUserLabel.font = NSFont.preferredFont(forTextStyle: .title1)
        selectUserLabel.textColor = .black
        
        
        let userStackView = NSStackView()
        userStackView.orientation = .vertical
        userStackView.wantsLayer = true
        userStackView.layer?.backgroundColor = NSColor.white.cgColor
        
        userViews = []
        for (number, user) in User.getUsers().enumerated() {
            currentUser = user
            
            let userView = GetViewForUser(user: user).view()
            userView.wantsLayer = true
            if number % 2 == 0 {
                userView.layer?.backgroundColor = NSColor.systemRed.cgColor
            } else {
                userView.layer?.backgroundColor = NSColor.systemYellow.cgColor
            }
            userViews.append(userView)
            
            
            let click = NSClickGestureRecognizer(target: self, action: #selector(changeLastLoggedInUser(_:)))
            userView.addGestureRecognizer(click)
            
            userStackView.addArrangedSubview(userView)
        }
        
//        userStackView.subviews = userViews
        
        
        
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
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
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
    
    @objc func changeLastLoggedInUser(_ sender: NSClickGestureRecognizer) {
        guard let currentUserView = sender.view as? IndividualUserView else {
            return
        }
        
        guard let currentUser = currentUserView.user else {
            return
        }

        User.lastLoggedInUser = currentUser
        print("user:", currentUser.username, "was clicked")
        
        if let parentViewController = parentViewController {
            parentViewController.changeViewToLogin()
        }
    }
}

class IndividualUserView: NSView {
    var user: User?
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
        userImageView.wantsLayer = true
        userImageView.layer?.cornerRadius = 15
        
        let usernameView = NSTextField(labelWithString: username)
        usernameView.textColor = .black
        
        let view = IndividualUserView(frame: NSRect(x: 0, y: 0, width: 300, height: 50))
        view.user = user
        
        view.subviews = [userImageView, usernameView]
        
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.systemYellow.cgColor
        view.layer?.cornerRadius = 10
        
        
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        usernameView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            userImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            userImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            userImageView.widthAnchor.constraint(equalToConstant: 30),
            userImageView.heightAnchor.constraint(equalToConstant: 30),
            
            usernameView.leftAnchor.constraint(equalTo: userImageView.rightAnchor, constant: 5),
            usernameView.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor),
            
            view.heightAnchor.constraint(equalToConstant: 50),
            view.widthAnchor.constraint(equalToConstant: 300),
        ])
        
        return view
    }
    
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
