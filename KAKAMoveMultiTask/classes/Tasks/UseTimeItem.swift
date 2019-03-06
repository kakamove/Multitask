//
//  UseTimeItem.swift
//  KAKAMoveMultiTask
//
//  Created by  on 2019/3/6.
//  Copyright © 2019 kakamove. All rights reserved.
//

import Cocoa

public extension Int {
    /*这是一个内置函数
     lower : 内置为 0，可根据自己要获取的随机数进行修改。
     upper : 内置为 UInt32.max 的最大值，这里防止转化越界，造成的崩溃。
     返回的结果： [lower,upper) 之间的半开半闭区间的数。
     */
    public static func randomIntNumber(lower: Int = 0,upper: Int = Int(UInt32.max)) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower)))
    }
    /**
     生成某个区间的随机数
     */
    public static func randomIntNumber(range: Range<Int>) -> Int {
        return randomIntNumber(lower: range.lowerBound, upper: range.upperBound)
    }
}

class UseTimeItem: NSObject {
    
    var timer: Timer?
    
    var progressMenuHandler: ((Double)->())?
    
    var allTime = Int.randomIntNumber(lower: 5, upper: 13)
    var usedTime = 0
    
    override init() {
        super.init()   
    }
    @objc func doUseTime() {
        usedTime += 1
        let progress = Double(usedTime)/Double(allTime)
        progressMenuHandler?(progress * 100)
        
        if usedTime >= allTime {
            timer?.invalidate()
            timer = nil
        }
        
        // developer上面做了修改
<<<<<<< HEAD
        // Master上面做了修改
=======
        
        //developer 上做了修改
>>>>>>> develop
    }
    
    func start() {
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(doUseTime),
                                     userInfo: nil,
                                     repeats: true)
        
        if let timer = timer {
            RunLoop.current.add(timer , forMode: RunLoop.Mode.common)
        }
    }
}
