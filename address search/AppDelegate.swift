//
//  AppDelegate.swift
//  address search
//
//  Created by Stephen Keable on 23/12/2015.
//  Copyright © 2015 Stephen Keable. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    
    var masterViewController: MasterViewController!
        
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        
        masterViewController = MasterViewController(nibName: "MasterViewController", bundle: nil)
        
        window.contentView!.addSubview(masterViewController.view)
        masterViewController.view.frame = (window.contentView! as NSView).bounds
        
        // 3. Set constraints on masterViewController.view
        masterViewController.view.translatesAutoresizingMaskIntoConstraints = false
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[subView]|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: ["subView" : masterViewController.view])
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[subView]|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: nil,
            views: ["subView" : masterViewController.view])
        
        NSLayoutConstraint.activateConstraints(verticalConstraints + horizontalConstraints)
        
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application

    }

}

