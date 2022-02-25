//
//  ViewController.swift
//  Reminder
//
//  Created by Arun Kumar on 18/02/22.
//

import Foundation
import AppKit

class AppLoginViewController: NSViewController, AppLoginViewControllerContract {
    private var currentView: NSView? = nil
    private var previousView: NSView? = nil
    private let welcomeView = WelcomeView()
    private let registrationView = RegistrationView()
    private let switchUserView = SwitchUserView()
    private let loginView = LoginView()
    var appLoginPresenter: AppLoginPresenterContract?
    
    
    
    private enum Views {
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
        
        appLoginPresenter = AppLoginPresenter()
        appLoginPresenter?.appLoginViewController = self
        
        loadAllViews()
        
        if appLoginPresenter?.getLastLoggedInUser() == nil {
            currentView = welcomeView
        } else {
            currentView = loginView
        }
        
        guard let currentView = currentView else {
            return
        }
        
        view = NSView(frame: NSRect(x: 0, y: 0, width: 600, height: 700))
        view.addSubview(currentView)
        
        currentView.translatesAutoresizingMaskIntoConstraints = false
        currentView.widthAnchor.constraint(equalToConstant: 600).isActive = true
        currentView.heightAnchor.constraint(equalToConstant: 700).isActive = true
    }
    
    func loadAllViews() {
        welcomeView.load(self)
        registrationView.load(self)
        switchUserView.load(self)
        loginView.load(self)
    }
    
    private func changeView(to selectedView: Views) {
        // detach from parent view
        previousView = currentView
        currentView?.removeFromSuperview()
        
        switch(selectedView) {
        case .welcomeView:
            welcomeView.load(self)
            currentView = welcomeView
            
        case .registrationView:
            registrationView.load(self)
            currentView = registrationView
            
        case .switchUserView:
            switchUserView.load(self)
            currentView = switchUserView
            
        case .loginView:
            loginView.load(self)
            currentView = loginView
        }
        
        // add to subview
        view.addSubview(currentView!)
        
        
        currentView?.translatesAutoresizingMaskIntoConstraints = false
        
        currentView?.widthAnchor.constraint(equalToConstant: 600).isActive = true
        currentView?.heightAnchor.constraint(equalToConstant: 700).isActive = true
        
    }
    
    
    
    func changeViewToRegistration() {
        self.changeView(to: .registrationView)
    }
    
    func changeViewToSwitchUser() {
        self.changeView(to: .switchUserView)
    }
    
    func changeViewToLogin() {
        self.changeView(to: .loginView)
    }
    
    
    func createUser(_ sender: RegistrationView) {
        let username = registrationView.usernameTextBox.stringValue
        let password = registrationView.passwordTextBox.stringValue
        let image = registrationView.image
        
        // proceed only if something is entered
        if username.count == 0 {
            return
        } else if password.count == 0 {
            return
        }
        
        let success = {
            [weak self]
            in
            sender.responseLabel.stringValue = "User created"
            sender.responseLabel.textColor = .systemGreen
            sender.responseLabel.isHidden = false
            self?.changeViewToSwitchUser()
        }
        let failure = {
            (message: String) in
            sender.responseLabel.stringValue = message
            sender.responseLabel.textColor = .systemRed
            sender.responseLabel.isHidden = false
        }

        appLoginPresenter?.createUser(username: username, password: password, image: image, onSuccess: success, onFailure: failure)
        
    }
    
    func getAvailableUsers() -> [User] {
        return appLoginPresenter?.getAvailableUsers() ?? []
        
    }
    
    func getLastLoggedInUser() -> User? {
        return appLoginPresenter?.getLastLoggedInUser()
    }
    
    func setLastLoggedInUser(user: User) {
        appLoginPresenter?.setLastLoggedInUser(user: user)
    }
    
    
}

