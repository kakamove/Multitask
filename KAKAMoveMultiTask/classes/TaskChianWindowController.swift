//
//  TaskChianWindowController.swift
//  KAKAMoveMultiTask
//
//  Created by  on 2019/3/5.
//  Copyright © 2019 kakamove. All rights reserved.
//

import Cocoa

class TaskChianWindowController: BaseWindowController {
    
    override func setupUI() {
        super.setupUI()
        taskTree1.isHidden = true
        taskTree2.isHidden = true
        taskTree3.isHidden = true
        window?.title = "Task Chian"
    }

    override func windowDidLoad() {
        super.windowDidLoad()
    }

}
