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
        
        let task1 = TestTask()
        let task2 = TestTask()
        let task3 = TestTask()
        let task4 = TestTask()
        let task5 = TestTask()
        let task6 = TestTask()
        
        task1.taskName = "task1"
        task2.taskName = "task2"
        task3.taskName = "task3"
        task4.taskName = "task4"
        task5.taskName = "task5"
        task6.taskName = "task6"
        let left = KAKAMoveTaskChain(tasks: [(task: task2, weight: 0.3),
                                             (task: task1, weight: 0.7)])
        let right = KAKAMoveTaskChain(tasks: [(task: task4, weight: 0.6),
                                              (task: task3, weight: 0.4)])
        let main = KAKAMoveTaskChain(tasks: [(task: task6, weight: 0.2),
                                             (task: task5, weight: 0.8)])
        
        taskTree = KAKAMoveTaskTree(main: main, weight: 0.3,
                                    left: left, weight: 0.4,
                                    right: right, weight: 0.3)
        
    }

}
