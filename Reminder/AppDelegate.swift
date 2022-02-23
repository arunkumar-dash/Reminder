//
//  AppDelegate.swift
//  Reminder
//
//  Created by Arun Kumar on 18/02/22.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet var window: NSWindow!
    var presenter: AppLoginPresenter?

    func applicationWillFinishLaunching(_ notification: Notification) {
        print("app will launch")
        presenter = AppLoginPresenter(window: window)
        
        let appLoginViewController = AppLoginViewController()
        presenter?.appLoginViewController = appLoginViewController
        
        presenter?.viewLoaded()
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        print("app launched")
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // save current user details
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

}

