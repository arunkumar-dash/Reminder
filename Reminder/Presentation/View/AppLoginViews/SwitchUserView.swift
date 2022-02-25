//
//  SwitchUserView.swift
//  Reminder
//
//  Created by Arun Kumar on 18/02/22.
//

import Foundation
import AppKit

class SwitchUserView: NSView {
    private var parentViewController: AppLoginViewControllerContract?
    
    func load(_ viewController: NSViewController) {
        
        guard let parentViewController = viewController as? AppLoginViewControllerContract else {
            return
        }
        
        self.parentViewController = parentViewController
        
        let createUserButton = NSButton(title: "Create User", target: self, action: #selector(createUser))
        
        let selectUserLabel = NSTextField(labelWithString: "Select User")
        selectUserLabel.font = NSFont.preferredFont(forTextStyle: .title1)
        selectUserLabel.textColor = .black
        
        
        let userStackView = NSStackView()
        userStackView.orientation = .vertical
        userStackView.wantsLayer = true
        userStackView.layer?.backgroundColor = NSColor.white.cgColor
        
        let availableUserList = parentViewController.getAvailableUsers()
        
        for user in availableUserList {
            
            let userView = GetViewForUser(user: user).getView()
            userView.wantsLayer = true
            userView.layer?.backgroundColor = NSColor.systemRed.cgColor
            
            
            let mouseClickGesture = NSClickGestureRecognizer(target: self, action: #selector(changeLastLoggedInUser(_:)))
            userView.addGestureRecognizer(mouseClickGesture)
            
            userStackView.addArrangedSubview(userView)
        }
        
        createUserButton.bezelColor = .red
        
        
        let containerScrollView = NSScrollView(frame: NSRect(x: 0, y: 0, width: 300, height: 300))
        containerScrollView.documentView = userStackView
        
        
        userStackView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        userStackView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        
        containerScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        self.subviews = [selectUserLabel, containerScrollView, createUserButton]
        
        
        selectUserLabel.translatesAutoresizingMaskIntoConstraints = false
        userStackView.translatesAutoresizingMaskIntoConstraints = false
        createUserButton.translatesAutoresizingMaskIntoConstraints = false
        containerScrollView.translatesAutoresizingMaskIntoConstraints = false

        
        
        NSLayoutConstraint.activate([
            selectUserLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            selectUserLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            
            
            containerScrollView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            containerScrollView.topAnchor.constraint(equalTo: selectUserLabel.bottomAnchor, constant: 100),
            containerScrollView.heightAnchor.constraint(equalToConstant: 300),
            containerScrollView.widthAnchor.constraint(equalToConstant: 300),
            
            
            createUserButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            createUserButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
        ])
    }
    
    @objc func changeLastLoggedInUser(_ sender: NSClickGestureRecognizer) {
        guard let currentUserView = sender.view as? IndividualUserView else {
            return
        }
        
        guard let currentUser = currentUserView.user else {
            return
        }

        parentViewController?.setLastLoggedInUser(user: currentUser)
        print("user:", currentUser.username, "was clicked")
        
        if let parentViewController = parentViewController {
            parentViewController.changeViewToLogin()
        }
    }
    
    @objc func createUser() {
        parentViewController?.changeViewToRegistration()
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
        self.userImage = user.image
        self.username = user.username
    }
    
    func getView() -> NSView {
        let defaultImage = NSImage(named: "user_icon")!
        defaultImage.size = NSSize(width: 40, height: 40)
        
        let userImageView = NSImageView(image: userImage ?? defaultImage)
        userImageView.wantsLayer = true
        userImageView.layer?.cornerRadius = 15
        
        let usernameView = NSTextField(labelWithString: username)
        usernameView.textColor = .black
        
        let userView = IndividualUserView(frame: NSRect(x: 0, y: 0, width: 300, height: 50))
        userView.user = user
        
        userView.subviews = [userImageView, usernameView]
        
        userView.wantsLayer = true
        userView.layer?.backgroundColor = NSColor.systemYellow.cgColor
        userView.layer?.cornerRadius = 10
        
        
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        usernameView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            userImageView.leftAnchor.constraint(equalTo: userView.leftAnchor, constant: 5),
            userImageView.centerYAnchor.constraint(equalTo: userView.centerYAnchor),
            userImageView.widthAnchor.constraint(equalToConstant: 30),
            userImageView.heightAnchor.constraint(equalToConstant: 30),
            
            usernameView.leftAnchor.constraint(equalTo: userImageView.rightAnchor, constant: 5),
            usernameView.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor),
            
            userView.heightAnchor.constraint(equalToConstant: 50),
            userView.widthAnchor.constraint(equalToConstant: 300),
        ])
        
        return userView
    }
    
}

class User {
    
    let image: NSImage?
    let username: String
    let password: String
    init(username: String, password: String, image: NSImage? = nil) {
        self.username = username
        self.password = password
        self.image = image
    }
    
}
