//
//  Task1.swift
//  KAKAMoveMultiTask
//
//  Created by  on 2019/3/6.
//  Copyright © 2019 kakamove. All rights reserved.
//

import Cocoa

class TestTask: KAKAMoveTask,KAKAMoveTaskDelegate {
    
    var useTimeItem: UseTimeItem?
    var taskName = ""
    
    
    func taskOutput(_ task: KAKAMoveTask) -> Any? {
        return "\(String(describing: self.className.components(separatedBy: ".").last)) output something"
    }
    
    func prepareAndStartTask(_ task: KAKAMoveTask) {
        useTimeItem = UseTimeItem()
        
        weak var weakSelf = self
        useTimeItem?.progressMenuHandler = { progress in
            weakSelf?.progress(progress)
        }
        useTimeItem?.start()
    }
    
    func puaseTask(_ task: KAKAMoveTask) {
    }
    func resumeTask(_ task: KAKAMoveTask) {
    }
    func cancleTask(_ task: KAKAMoveTask) {
    }
    deinit {
        print(String(describing: self.className.components(separatedBy: ".").last!) + "  deinit")
    }
    
    override init() {
        super.init()
        delegate = self
    }
}

extension TestTask {
    
    func progress(_ progress: Double) {
        print("\(String(describing: self.className.components(separatedBy: ".").last!)) progress = \(progress)")
        
        self.progress = (Float(progress),nil)
        
        if progress == 100 {
            complate()
        }
    }
    
    
}
