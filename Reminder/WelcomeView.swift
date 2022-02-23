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
    let button = NSButton(title: "Create User", target: self, action: #selector(AppLoginViewController.changeViewToRegistration))
    
    func load() {
        
        headline.font = NSFont.preferredFont(forTextStyle: .largeTitle)
        headline.textColor = .black
        subheadline.font = NSFont.preferredFont(forTextStyle: .title1)
        subheadline.textColor = .black
        button.bezelColor = .blue
        
        
        addSubview(headline)
        addSubview(subheadline)
        addSubview(button)
        
        
        
        headline.translatesAutoresizingMaskIntoConstraints = false
        subheadline.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            headline.centerXAnchor.constraint(equalTo: centerXAnchor),
            headline.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            
            subheadline.centerXAnchor.constraint(equalTo: centerXAnchor),
            subheadline.topAnchor.constraint(equalTo: headline.bottomAnchor, constant: 50),
            
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
        ])
    }
}
