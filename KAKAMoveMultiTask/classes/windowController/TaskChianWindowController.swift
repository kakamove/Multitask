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
        let taskChain = KAKAMoveTaskChain(tasks: [(task: task1, weight: 0.1),
                                                  (task: task2, weight: 0.2),
                                                  (task: task3, weight: 0.3),
                                                  (task: task4, weight: 0.2),
                                                  (task: task5, weight: 0.1),
                                                  (task: task6, weight: 0.1)])
        taskTree = KAKAMoveTaskTree(main: taskChain)
    }

}
