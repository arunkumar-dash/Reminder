//
//  RegistrationViewController.swift
//  Reminder
//
//  Created by Arun Kumar on 18/02/22.
//

import Foundation
import AppKit

class RegistrationView: NSView {
    let username = NSTextField()
    let password = NSSecureTextField()
    
    
    func load(_ viewController: AppLoginViewController) {
        let button = viewController.createUserButtonInRegistrationView
        
        guard let image = NSImage(named: "user_icon") else { return }
        let imageView = NSImageView(image: image)
        
        
        username.wantsLayer = true
        username.layer?.backgroundColor = NSColor.systemGray.cgColor
        username.layer?.cornerRadius = 10
        username.layer?.borderColor = .black
        username.layer?.borderWidth = 1
        
        
        username.placeholderString = "User Name"
        username.isBordered = true
        username.backgroundColor = .gray
        username.textColor = .white
        username.font = .preferredFont(forTextStyle: .title2)
        username.alignment = .center
        
        
        password.wantsLayer = true
        password.layer?.cornerRadius = 10
        password.layer?.backgroundColor = NSColor.systemGray.cgColor
        password.layer?.borderColor = .black
        password.layer?.borderWidth = 1
        
     
        password.placeholderString = "Password"
        password.isBordered = true
        password.backgroundColor = .gray
        password.textColor = .white
        password.font = .preferredFont(forTextStyle: .title2)
        password.alignment = .center
        
        
        button.bezelColor = .brown
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        username.translatesAutoresizingMaskIntoConstraints = false
        password.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        subviews = [imageView, username, password, button]
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            imageView.bottomAnchor.constraint(equalTo: topAnchor, constant: 250),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            
            username.centerXAnchor.constraint(equalTo: centerXAnchor),
            username.topAnchor.constraint(equalTo: centerYAnchor),
            username.widthAnchor.constraint(equalToConstant: 250),
            username.heightAnchor.constraint(equalToConstant: 30),
            
            password.centerXAnchor.constraint(equalTo: centerXAnchor),
            password.topAnchor.constraint(equalTo: username.bottomAnchor, constant: 20),
            password.widthAnchor.constraint(equalToConstant: 250),
            password.heightAnchor.constraint(equalToConstant: 30),
            
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
        ])
    }
    
}
