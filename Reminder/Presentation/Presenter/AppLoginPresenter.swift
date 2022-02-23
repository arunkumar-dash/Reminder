//
//  AppLoginPresenter.swift
//  Reminder
//
//  Created by Arun Kumar on 23/02/22.
//

import Foundation
import AppKit

public class AppLoginPresenter {
    weak var appLoginViewController: AppLoginViewControllerContract?
    private var window: NSWindow
    
    init(window: NSWindow) {
        self.window = window
    }
    
    public func viewLoaded() {
        window.contentViewController = appLoginViewController
        
        let size = NSSize(width: 600, height: 700)
        window.maxSize = size
        window.minSize = size
        
        // hiding full screen button
        let maximizeButton = window.standardWindowButton(.zoomButton)
        maximizeButton?.isHidden = true
    }
}
