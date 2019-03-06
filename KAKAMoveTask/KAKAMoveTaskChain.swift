

import Cocoa

/// 任务链条，需要将任务链有序放入,双向链,各个任务是前后依赖关系。
class KAKAMoveTaskChain: NSObject {
    
    private var tasks: [KAKAMoveTask]?

    weak var taskTree: KAKAMoveTaskTree?
    var previousTaskChainsInfor: Any? {
        didSet {
            tasks?.last?.previousTaskChainsInfor = previousTaskChainsInfor
        }
    }
    
    var weightInTree: Float = 1
    
    /// 多任务输出的整体进度,可能附带进度缩略图等信息
    var progress: (value:Float,information: [AnyHashable: Any]?) = (0,nil) {
        didSet {
           taskTree?.calculateTreeProgress(with: self, progress: progress.value, information: progress.information)
        }
    }
    
    /// 任务链中活跃的任务
    var activeTask: KAKAMoveTask? {
        // 找到任务链中活跃的任务后暂停它
        guard let task = tasks else {
            return nil
        }
        for task in task {
            if task.isActive {
                return task
            }
        }
        return nil
    }
    var isfinished = false {
        didSet {
            if isfinished {
                taskTree?.oneChainDidFinished(self)
            }
        }
    }
    
    /// 这条链完成后的产出
    var output: Any? {
        didSet {
            isfinished = true
            isActive = false
        }
    }
    
    var isActive = false
    
    init(tasks truples: [(task: KAKAMoveTask,weight: Float)]) {
        for taskTruple in truples {
            taskTruple.0.weight = taskTruple.1
        }
        let tasks = truples.map { (taskTruple) -> KAKAMoveTask in
            taskTruple.0
        }
        self.tasks = tasks
        super.init()
        
        linkTasks()
    }
    
    deinit {
        print("Export TaskChian deinit")
        tasks = nil
    }
    
    
    func start() {
        tasks?.first?.standBy()
    }
    func pause() {
        activeTask?.pause()
    }
    func resume() {
        activeTask?.resume()
    }
    func cancle() {
        activeTask?.cancle()
    }
    
    /// 任务链输出总进度计算
    ///
    /// - Parameters:
    ///   - progress: 某个任务的进度
    ///   - task: 单个任务
    ///   - 和进度相关的图像信息等
    func calculateChainProgress(with task: KAKAMoveTask, progress: Float, information: [AnyHashable:Any]? = nil) {
        guard let tasks = tasks else {
            return
        }
        var singleProgressArray = tasks.map({ (task) -> Float in 0 })
        
        for i in task.indexInTaskChian ..< tasks.count {
            singleProgressArray[i] = tasks[i].weight * 100
        }
        singleProgressArray[task.indexInTaskChian] = task.weight * progress
        //        print(singleProgressArray) Log Skip
        self.progress = (value: singleProgressArray.reduce(0, { x, y in x + y }),
                         information: information)
    }
    
    /// 拼接输出任务
    func linkTasks() {
        guard let tasks = tasks else {
            return
        }
        for (index,task) in tasks.enumerated() {
            task.indexInTaskChian = index
            task.taskChain = self
            if index + 1 < tasks.count {
                task.previousTask = tasks[index + 1]
            }
            if index - 1 >= 0 {
                task.nextTask = tasks[index - 1]
            }
        }
    }
}
