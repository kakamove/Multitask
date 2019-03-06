//
//  TaskBase.swift
//  多任务
//
//  Created by  on 2019/1/30.
//  Copyright © 2019 ws. All rights reserved.
//

import Cocoa

enum KAKAMoveTaskType {
    case DVDMenu
    case ISOToDVD
    case TSFolderToDVDMdeia
    case VideoToTSFolder
    case TimelineToVideo
    case TSFolderToISO
    case VideoToSocial
    case VideoToTimeLine
}

protocol KAKAMoveTaskDelegate: class {
    
    /// 任务完成后的产出
    ///
    /// - Parameter task: task
    /// - Returns: 任务产出 比如一个视频路径
    func taskOutput(_ task: KAKAMoveTask) -> Any?
    
    /// 准备任务 和 开始任务
    ///
    /// - Parameter task: TaskBase
    func prepareAndStartTask(_ task: KAKAMoveTask)

    func puaseTask(_ task: KAKAMoveTask)
    func resumeTask(_ task: KAKAMoveTask)
    func cancleTask(_ task: KAKAMoveTask)
}

class KAKAMoveTask: NSObject {
    var taskType: KAKAMoveTaskType = .TimelineToVideo
    
    weak var delegate: KAKAMoveTaskDelegate?
    
    /// 这个任务依赖的任务: 上传任务的previousTask是本地视频生成任务；和nextTask对应
    weak var previousTask: KAKAMoveTask?{
        didSet{
            previousTask?.nextTask = self
        }
    }
    /// 这个任务依赖的任务的产出: 上传任务的previousTaskInfor是本地视频生成任务的视频路径；和nextTask对
    var previousTaskInfor: Any?
    
    /// 进行完这个任务的下一个任务：本地视频生成任务的nextTask可能是上传任务；和previousTask对应
    var nextTask: KAKAMoveTask?

    /// 此任务是否是活跃状态
    var isActive = false {
        didSet {
            if isActive {
                taskChain?.isActive = true
            }
        }
    }
    
    var progress: (value:Float,information: [AnyHashable: Any]?) = (0,nil) {
        didSet {
            taskChain?.calculateChainProgress(with: self, progress: progress.value, information: progress.information)
        }
    }
    
    /// 在任务链中的权重，用于计算多任务整体进度。
    var weight: Float = 1
    
    var indexInTaskChian: Int = 0
    
    
    /// 这个任务所在的任务链
    weak var taskChain: KAKAMoveTaskChain?
    /// 这个任务如果有两个子链的话： 要拿着两个子链产出的合集开始
    var previousTaskChainsInfor: Any?
    
    var isCanPause: Bool  = true
    var isCanCancel: Bool = true
    
//    deinit {
//        print(String(describing: self.className.components(separatedBy: ".").last!) + "  deinit")
//    }
    
    //MARK: - Start And End
    //必须在开始任务前调用此方法
    final func standBy() {
        if previousTask == nil {
            start()
        }
        if previousTask != nil {
            previousTask?.standBy()
        }
    }
    
    fileprivate func start() {
        print("========== Start An Export Task ==============")
        print("TASK PREPARE AND START \(String(describing: self.className.components(separatedBy: ".").last!))")
        print("TASK PREVIOUS TASK INFOR = \(String(describing: previousTaskInfor))")
        print("TASK PREVIOUS CHAINS INFOR = \(String(describing: previousTaskInfor))")
        delegate?.prepareAndStartTask(self)
        
        isActive = true
        previousTask?.isActive = false
    }
    
    // 子类必须在成功之后调用此方法
    final func complate() {
        print("TASK COMPLETE \(self.className.components(separatedBy: ".").last!)")
        if nextTask != nil {
            nextTask?.previousTaskInfor = delegate?.taskOutput(self)
        } else {
            // self作为链条中最后一个任务执行结束，意味着链条结束。
            taskChain?.output = delegate?.taskOutput(self)
        }
        nextTask?.start()
    }

    //MARK: - Puase Cancle & Resume
    final func pause() {
        print("TASK \(self.className.components(separatedBy: ".").last!) WILL PAUSE")
        delegate?.puaseTask(self)
    }
    final func resume() {
        print("TASK \(self.className.components(separatedBy: ".").last!) WILL RESUME")
        delegate?.resumeTask(self)
    }
    
    final func cancle() {
        print("TASK \(self.className.components(separatedBy: ".").last!) WILL CANCLE")
        delegate?.cancleTask(self)
    }
}
