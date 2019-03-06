//
//  TaskTreeWindowController.swift
//  KAKAMoveMultiTask
//
//  Created by  on 2019/3/5.
//  Copyright © 2019 kakamove. All rights reserved.
//

import Cocoa

class TaskTreeWindowController: BaseWindowController {
    
    override func setupUI() {
        super.setupUI()
        window?.title = "Task Tree"
        taskChian.isHidden = true
    }

    override func windowDidLoad() {
        super.windowDidLoad()
        
    }

}
