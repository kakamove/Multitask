//
//  ExportTaskTree.swift
//  WSVEOnline
//
//  Created by  on 2019/2/26.
//  Copyright © 2019 wangxiaoyan. All rights reserved.
//

import Cocoa

extension NSNotification.Name {
    static let AllProgressDidChanged = NSNotification.Name("AllProgressDidChanged")
    static let AllProgressDidEnd = NSNotification.Name("AllProgressDidEnd")
    
    static let SubProgressDidChanged = NSNotification.Name("SubProgressDidChanged")
}

class KAKAMoveTaskTree: NSObject {
    
    var main:  KAKAMoveTaskChain
    var right: KAKAMoveTaskChain?
    var left:  KAKAMoveTaskChain?
    
    var activeChian: KAKAMoveTaskChain? {
        if main.isActive {
            return main
        }
        if let left = left,left.isActive {
            return left
        }
        if let right = right,right.isActive {
            return right
        }
        return nil
    }
    
    var output: Any?  {
        didSet {
            isFinished = true
        }
    }
    var progress: (value:Float,information: [AnyHashable: Any]?) = (0,nil) {
        didSet {
            
            print("___ Task progress value = \(self.progress.value)")
            NotificationCenter.default.post(name: NSNotification.Name.AllProgressDidChanged,
                                            object: CGFloat(self.progress.value),
                                            userInfo: self.progress.1)
        }
    }

    var isFinished: Bool = false {
        didSet {
            if isFinished {
                NotificationCenter.default.post(name: NSNotification.Name.AllProgressDidEnd, object: nil, userInfo: nil)
            }
        }
    }
    
    init(main mainChain :KAKAMoveTaskChain,
         weight mainWeight: Float = 1,
         left leftChian:KAKAMoveTaskChain? = nil,
         weight leftWeight: Float? = nil,
         right rightChian: KAKAMoveTaskChain? = nil,
         weight rightWeight: Float? = nil) {
        
        self.main  = mainChain
        self.left  = leftChian
        self.right = rightChian
        self.main.weightInTree   = mainWeight
        self.left?.weightInTree  = leftWeight ?? (1-mainWeight)*0.5
        self.right?.weightInTree = rightWeight ?? (1-mainWeight)*0.5
        
        super.init()
        
        self.main.taskTree = self
        self.left?.taskTree = self
        self.right?.taskTree = self
    }
    
    
    func start() {
        if let leftChain = left {
            leftChain.start()
        } else {
            main.start()
        }
    }
    func pause() {
        activeChian?.pause()
    }
    func resume() {
        activeChian?.resume()
    }
    func cancle() {
        activeChian?.cancle()
    }
    
    func oneChainDidFinished(_ chian: KAKAMoveTaskChain) {
        if chian === main {
            output = main.output
        }
        if chian === left {
            right?.start()
        }
        if chian === right {
            main.previousTaskChainsInfor = [left?.output,right?.output]
            main.start()
        }
    }
    
    func calculateTreeProgress(with task: KAKAMoveTaskChain, progress: Float, information: [AnyHashable:Any]? = nil) {
        var progressValue: Float = 0
        if task === left {
            progressValue = progress*(left?.weightInTree ?? 0)
        }
        if task === right {
            progressValue = progress*(right?.weightInTree ?? 0) + (left?.weightInTree ?? 0)*100
        }
        if task === main {
            let completedProgress_left  = (left?.weightInTree ?? 0)*100
            let completedProgress_right = (right?.weightInTree ?? 0)*100
            progressValue = progress*main.weightInTree + completedProgress_left + completedProgress_right
        }
        self.progress = (progressValue,information)
    }
    
    deinit {
        print("Export TaskTree deinit ")
    }
}
