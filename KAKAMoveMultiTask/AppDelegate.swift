//
//  AppDelegate.swift
//  KAKAMoveMultiTask
//
//  Created by  on 2019/3/4.
//  Copyright © 2019 kakamove. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    
    @IBAction func showTaskChain(_ sender: Any) {
        let chainWindowController = TaskChianWindowController()
        if let wnd = chainWindowController.window {
            wnd.makeKeyAndOrderFront(nil)
            NSApp.runModal(for: wnd)
        }
    }
    @IBAction func showTaskTree(_ sender: Any) {
        
        let treeWindowController = TaskTreeWindowController()
        if let wnd = treeWindowController.window {
            wnd.makeKeyAndOrderFront(nil)
            NSApp.runModal(for: wnd)
        }
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        
    }


}

