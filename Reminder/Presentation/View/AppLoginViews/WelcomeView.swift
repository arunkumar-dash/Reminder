//
//  WelcomeView.swift
//  Reminder
//
//  Created by Arun Kumar on 22/02/22.
//

import Foundation
import AppKit

class WelcomeView: NSView {
    let headline = NSTextField(labelWithString: "Welcome to Reminder!")
    let subheadline = NSTextField(labelWithString: "To start, create user.")
    
    private var parentViewController: AppLoginViewControllerContract?
    
    func load(_ viewController: NSViewController) {
        let createUserButton = NSButton(title: "Create User", target: self, action: #selector(createUser))
        
        guard let parentViewController = viewController as? AppLoginViewControllerContract else {
            return
        }
        
        self.parentViewController = parentViewController
        
        headline.font = NSFont.preferredFont(forTextStyle: .largeTitle)
        headline.textColor = .black
        
        subheadline.font = NSFont.preferredFont(forTextStyle: .title1)
        subheadline.textColor = .black
        
        createUserButton.bezelColor = .blue
        
        
        addSubview(headline)
        addSubview(subheadline)
        addSubview(createUserButton)
        
        
        
        headline.translatesAutoresizingMaskIntoConstraints = false
        subheadline.translatesAutoresizingMaskIntoConstraints = false
        createUserButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            headline.centerXAnchor.constraint(equalTo: centerXAnchor),
            headline.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            
            subheadline.centerXAnchor.constraint(equalTo: centerXAnchor),
            subheadline.topAnchor.constraint(equalTo: headline.bottomAnchor, constant: 50),
            
            createUserButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            createUserButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
        ])
    }
    
    @objc func createUser() {
        parentViewController?.changeViewToRegistration()
    }
}
