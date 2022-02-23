//
//  ViewController.swift
//  Reminder
//
//  Created by Arun Kumar on 18/02/22.
//

import Foundation
import AppKit

class AppLoginViewController: NSViewController {
    var currentView: NSView? = nil
    let welcomeView = WelcomeView()
    let registrationView = RegistrationView()
    let switchUserView = SwitchUserView()
    let loginView = LoginView()
    
    
    let createUserButtonInSwitchUserView = NSButton(title: "Create User", target: self, action: #selector(AppLoginViewController.changeViewToRegistration))
    
    
    let createUserButtonInRegistrationView = NSButton(title: "Create User", target: self, action: #selector(createUser))
    
    
    enum Views {
        case welcomeView
        case registrationView
        case switchUserView
        case loginView
    }
    
    
    override func viewDidLoad() {
        print("view loaded")
        
        
        view.wantsLayer = true
        view.layer?.backgroundColor = .white
    }
    
    override func loadView() {
        
        loadAllViews()
        
        currentView = welcomeView
        
        view = NSView(frame: NSRect(x: 0, y: 0, width: 600, height: 700))
        view.addSubview(welcomeView)
        
        welcomeView.translatesAutoresizingMaskIntoConstraints = false
        welcomeView.widthAnchor.constraint(equalToConstant: 600).isActive = true
        welcomeView.heightAnchor.constraint(equalToConstant: 700).isActive = true
    }
    
    func loadAllViews() {
        welcomeView.load()
        registrationView.load(self)
        switchUserView.load(self)
        loginView.load()
    }
    
    func changeView(to selectedView: Views) {
        currentView?.removeFromSuperview()
        
        switch(selectedView) {
        case .welcomeView:
            welcomeView.load()
            currentView = welcomeView
            
        case .registrationView:
            registrationView.load(self)
            currentView = registrationView
            
        case .switchUserView:
            switchUserView.load(self)
            currentView = switchUserView
            
        case .loginView:
            loginView.load()
            currentView = loginView
        }
        
        // remove subview also
        view.addSubview(currentView!)
        
        
        currentView?.translatesAutoresizingMaskIntoConstraints = false
        
        currentView?.widthAnchor.constraint(equalToConstant: 600).isActive = true
        currentView?.heightAnchor.constraint(equalToConstant: 700).isActive = true
        
        // alt for
        // try this else, view = welcomeViewController
    }
    
    
    
    @objc func changeViewToWelcome() {
        self.changeView(to: .welcomeView)
    }
    
    @objc func changeViewToRegistration() {
        self.changeView(to: .registrationView)
    }
    
    @objc func changeViewToSwitchUser() {
        self.changeView(to: .switchUserView)
    }
    
    @objc func changeViewToLogin() {
        self.changeView(to: .loginView)
    }
    
    
    @objc func createUser(_ sender: RegistrationView) {
        let username = registrationView.username.stringValue
        let password = registrationView.password.stringValue
        
        // validate credentials
        if username.count == 0 {
            return
        } else if password.count == 0 {
            return
        }
        
        User.users.append(User(username: username, password: password))
        print("user added to database")
        print("username:", username)
        print("passowrd:", password)
        
        
        
        changeViewToSwitchUser()
        
    }
    
}
