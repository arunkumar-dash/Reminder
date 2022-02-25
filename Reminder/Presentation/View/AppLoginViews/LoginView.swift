//
//  LoginView.swift
//  Reminder
//
//  Created by Arun Kumar on 18/02/22.
//

import Foundation
import AppKit

class LoginView: NSView, NSGestureRecognizerDelegate {
    private var password = NSSecureTextField()
    private let incorrectPassword = NSTextField(labelWithString: "Incorrect password")
    private var parentViewController: AppLoginViewControllerContract?
    
    func load(_ viewController: NSViewController) {
        
        guard let parentViewController = viewController as? AppLoginViewControllerContract else {
            return
        }
        
        self.parentViewController = parentViewController
        
        guard let lastLoggedInUser = parentViewController.getLastLoggedInUser() else {
            print("No user in db")
            return
        }
        
        
        let defaultImage = NSImage(named: "user_icon")!
        
        let username = NSTextField(labelWithString: lastLoggedInUser.username)
        username.font = NSFont.preferredFont(forTextStyle: .title3)
        username.textColor = .black
        
        password.placeholderString = "Enter password"
        password.isHidden = true
        password.backgroundColor = .gray
        password.textColor = .white
        password.drawFocusRingMask()
        password.stringValue = ""
        
        incorrectPassword.isHidden = true
        incorrectPassword.font = NSFont.preferredFont(forTextStyle: .footnote)
        incorrectPassword.textColor = .red
        
        let userImage = NSImageView(image: lastLoggedInUser.image ?? defaultImage)
        userImage.wantsLayer = true
        userImage.layer?.cornerRadius = 100
        
        let mouseClick = NSClickGestureRecognizer(target: self, action: #selector(getPasswordFromUser))
        userImage.addGestureRecognizer(mouseClick)
        
        
        self.subviews = [userImage, username, password, incorrectPassword]
        
        userImage.translatesAutoresizingMaskIntoConstraints = false
        username.translatesAutoresizingMaskIntoConstraints = false
        password.translatesAutoresizingMaskIntoConstraints = false
        incorrectPassword.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            
            userImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            userImage.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -50),
            userImage.heightAnchor.constraint(equalToConstant: 200),
            userImage.widthAnchor.constraint(equalToConstant: 200),
            
            username.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            username.topAnchor.constraint(equalTo: userImage.topAnchor, constant: 250),
            
            password.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            password.topAnchor.constraint(equalTo: username.bottomAnchor, constant: 20),
            password.widthAnchor.constraint(equalToConstant: 250),
            password.heightAnchor.constraint(equalToConstant: 30),
            
            incorrectPassword.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            incorrectPassword.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 20),
        ])
    }
    
    @objc func getPasswordFromUser() {
        password.isHidden = false
        password.action = #selector(validatePassword)
    }
    
    @objc func validatePassword() {
        print("password:", password.stringValue)
        
        let lastLoggedInUser = parentViewController?.getLastLoggedInUser()
        
        if lastLoggedInUser?.password == password.stringValue {
            //log in
            print("logged in")
            incorrectPassword.isHidden = true
            
            // dashboard view
        } else {
            incorrectPassword.isHidden = false
        }
    }
    
    // submit on pressing return key
    override func keyUp(with event: NSEvent) {
        let RETURN_KEY_CODE = 36
        if event.keyCode == RETURN_KEY_CODE {
            validatePassword()
        }
    }
    
}
