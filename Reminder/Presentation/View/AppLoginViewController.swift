//
//  ViewController.swift
//  Reminder
//
//  Created by Arun Kumar on 18/02/22.
//

import Foundation
import AppKit

class AppLoginViewController: NSViewController, AppLoginViewControllerContract {
    private var currentView: AppLoginViewContract? = nil
    private var previousViews: [AppLoginViewContract] = []
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
        view.layer?.contents = NSImage(named: "background")
    }
    
    override func loadView() {
        
        appLoginPresenter = AppLoginPresenter()
        appLoginPresenter?.appLoginViewController = self
        
        
        if appLoginPresenter?.getLastLoggedInUser() == nil {
            currentView = welcomeView
        } else {
            currentView = loginView
        }
        
        currentView?.load(self)
        
        guard let currentView = currentView else {
            return
        }
        
        view = NSView(frame: NSRect(x: 0, y: 0, width: 600, height: 700))
        view.addSubview(currentView)
        
        currentView.translatesAutoresizingMaskIntoConstraints = false
        currentView.widthAnchor.constraint(equalToConstant: 600).isActive = true
        currentView.heightAnchor.constraint(equalToConstant: 700).isActive = true
    }
    
    private func fadeIn(_ view: NSView) {
        let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
        fadeInAnimation.fromValue = 0.5
        fadeInAnimation.toValue = view.alphaValue
        fadeInAnimation.duration = 0.25
        self.view.wantsLayer = true
        self.view.layer?.add(fadeInAnimation, forKey: nil)
    }
    
    private func changeView(to selectedView: Views) {
        // detach from parent view
        if let currentView = currentView {
            previousViews.append(currentView)
        }
        currentView?.removeFromSuperview()
        
        switch(selectedView) {
        case .welcomeView:
            currentView = welcomeView
            
        case .registrationView:
            currentView = registrationView
            
        case .switchUserView:
            currentView = switchUserView
            
        case .loginView:
            currentView = loginView
        }
        
        guard let currentView = currentView else {
            print("currentView is nil")
            return
        }

        
        fadeIn(currentView)
        // add to subview
        view.addSubview(currentView)
        currentView.load(self)
        
        
        currentView.translatesAutoresizingMaskIntoConstraints = false
        
        currentView.widthAnchor.constraint(equalToConstant: 600).isActive = true
        currentView.heightAnchor.constraint(equalToConstant: 700).isActive = true
        
    }
    
    func navigateBackToPreviousView() {
        currentView?.removeFromSuperview()
        currentView = previousViews.popLast()
        guard let currentView = currentView else {
            return
        }
        fadeIn(currentView)
        view.addSubview(currentView)
        currentView.load(self)
        
        currentView.translatesAutoresizingMaskIntoConstraints = false
        
        currentView.widthAnchor.constraint(equalToConstant: 600).isActive = true
        currentView.heightAnchor.constraint(equalToConstant: 700).isActive = true
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
        let image = registrationView.userImageView.image
        
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



