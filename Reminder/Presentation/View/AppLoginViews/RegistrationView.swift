//
//  RegistrationViewController.swift
//  Reminder
//
//  Created by Arun Kumar on 18/02/22.
//

import Foundation
import AppKit

class RegistrationView: NSView {
    
    let usernameTextBox = NSTextField()
    let passwordTextBox = NSSecureTextField()
    // should get image
    let image: NSImage? = NSImage(named: "user_icon")
    let createUserButton = NSButton(title: "Create User", target: self, action: #selector(createUser))
    let responseLabel: NSTextField = NSTextField(labelWithString: "")
    
    private var parentViewController: AppLoginViewControllerContract?
    
    func load(_ viewController: NSViewController) {
        
        guard let parentViewController = viewController as? AppLoginViewControllerContract else {
            return
        }
        
        self.parentViewController = parentViewController
        
        
        guard let mockImage = NSImage(named: "user_icon") else { return }
        let mockImageView = NSImageView(image: mockImage)
        
        
        usernameTextBox.wantsLayer = true
        usernameTextBox.layer?.backgroundColor = NSColor.systemGray.cgColor
        usernameTextBox.layer?.cornerRadius = 10
        usernameTextBox.layer?.borderColor = .black
        usernameTextBox.layer?.borderWidth = 1
        
        
        usernameTextBox.placeholderString = "User Name"
        usernameTextBox.isBordered = true
        usernameTextBox.backgroundColor = .gray
        usernameTextBox.textColor = .white
        usernameTextBox.font = .preferredFont(forTextStyle: .title2)
        usernameTextBox.alignment = .center
        usernameTextBox.stringValue = ""
        
        
        passwordTextBox.wantsLayer = true
        passwordTextBox.layer?.cornerRadius = 10
        passwordTextBox.layer?.backgroundColor = NSColor.systemGray.cgColor
        passwordTextBox.layer?.borderColor = .black
        passwordTextBox.layer?.borderWidth = 1
        
     
        passwordTextBox.placeholderString = "Password"
        passwordTextBox.isBordered = true
        passwordTextBox.backgroundColor = .gray
        passwordTextBox.textColor = .white
        passwordTextBox.font = .preferredFont(forTextStyle: .title2)
        passwordTextBox.alignment = .center
        passwordTextBox.stringValue = ""
        
        responseLabel.isHidden = true
        
        createUserButton.bezelColor = .brown
        
        
        
        mockImageView.translatesAutoresizingMaskIntoConstraints = false
        usernameTextBox.translatesAutoresizingMaskIntoConstraints = false
        passwordTextBox.translatesAutoresizingMaskIntoConstraints = false
        createUserButton.translatesAutoresizingMaskIntoConstraints = false
        responseLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        subviews = [mockImageView, usernameTextBox, passwordTextBox, responseLabel, createUserButton]
        
        NSLayoutConstraint.activate([
            mockImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mockImageView.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            mockImageView.bottomAnchor.constraint(equalTo: topAnchor, constant: 250),
            mockImageView.heightAnchor.constraint(equalToConstant: 150),
            
            usernameTextBox.centerXAnchor.constraint(equalTo: centerXAnchor),
            usernameTextBox.topAnchor.constraint(equalTo: centerYAnchor),
            usernameTextBox.widthAnchor.constraint(equalToConstant: 250),
            usernameTextBox.heightAnchor.constraint(equalToConstant: 30),
            
            passwordTextBox.centerXAnchor.constraint(equalTo: centerXAnchor),
            passwordTextBox.topAnchor.constraint(equalTo: usernameTextBox.bottomAnchor, constant: 20),
            passwordTextBox.widthAnchor.constraint(equalToConstant: 250),
            passwordTextBox.heightAnchor.constraint(equalToConstant: 30),
            
            responseLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            responseLabel.topAnchor.constraint(equalTo: passwordTextBox.bottomAnchor, constant: 20),
            
            
            createUserButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            createUserButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
        ])
    }
    
    @objc func createUser() {
        parentViewController?.createUser(self)
    }
    
}
