//
//  BaseWindowController.swift
//  KAKAMoveMultiTask
//
//  Created by  on 2019/3/5.
//  Copyright © 2019 kakamove. All rights reserved.
//

import Cocoa




class BaseWindowController: NSWindowController,NSWindowDelegate {
    
    var taskTree: KAKAMoveTaskTree?
    
    @IBOutlet weak var subProgress: NSTextField!
    @IBOutlet weak var allProgress: NSTextField!
    @IBOutlet weak var startButton: NSButton!
    
    @IBOutlet weak var progressBar: NSProgressIndicator!
    
    
    @IBOutlet weak var taskChian: NSTextField!
    
    @IBOutlet weak var taskTree1: NSTextField!
    @IBOutlet weak var taskTree2: NSTextField!
    @IBOutlet weak var taskTree3: NSTextField!
    
    
    @IBAction func start(_ sender: NSButton) {
        taskTree?.start()
        sender.isEnabled = false
    }
    
    func setupUI() {
        
    }
    
    
    @objc func recvAllProgressDidChanged(_ notifi: Notification) {
        if let progress = notifi.object as? CGFloat {
            progressBar.doubleValue = Double(progress)
            allProgress.stringValue = "All:" + " \(Int(progress))" + "%"
        }
    }
    
    @objc func recvAllProgressDidEnd(_ notifi: Notification) {
        startButton.isEnabled = true
        taskTree = nil
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AllProgressDidEnd, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AllProgressDidChanged, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.SubProgressDidChanged, object: nil)
    }
    
    @objc func recvSubProgressDidChanged(_ notifi: Notification) {
        if let progress = notifi.object as? CGFloat {
            let taskName = taskTree?.activeChian?.activeTask?.className.components(separatedBy: ".").last ?? ""
            subProgress.stringValue = "\(taskName):" + " \(Int(progress))" + "%"
        }
    }
    
    override var windowNibName: NSNib.Name? {
        return NSNib.Name("BaseWindowController")
    }

    override func windowDidLoad() {
        super.windowDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(recvAllProgressDidChanged(_:)), name: NSNotification.Name.AllProgressDidChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(recvAllProgressDidEnd(_:)), name: NSNotification.Name.AllProgressDidEnd, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(recvSubProgressDidChanged(_:)), name: NSNotification.Name.SubProgressDidChanged, object: nil)
        
        setupUI()
        
    }
    
    func windowWillClose(_ notification: Notification) {
        NSApp.abortModal()
        window?.orderOut(nil)
    }
    
}
