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

    func applicationWillFinishLaunching(_ notification: Notification) {
        print("app will launch")
        
        let appLoginViewController = AppLoginViewController()
        
        window.contentViewController = appLoginViewController
        let size = NSSize(width: 600, height: 700)
        window.maxSize = size
        window.minSize = size

        // hiding full screen button
        let maximizeButton = window.standardWindowButton(.zoomButton)
        maximizeButton?.isHidden = true
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

