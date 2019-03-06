//
//  AppDelegate.swift
//  KAKAMoveMultiTask
//
//  Created by  on 2019/3/4.
//  Copyright © 2019 kakamove. All rights reserved.
//

import Cocoa

func RunCenteredModal(_ window: NSWindow?,in upperWindow: NSWindow?) {
    if let wnd = window,let upperWindow = upperWindow,let upperWindowContentView = upperWindow.contentView {
        let origin = NSMakePoint(upperWindowContentView.center.x + upperWindow.frame.origin.x - wnd.frame.size.width * 0.5,
                                 upperWindowContentView.center.y + upperWindow.frame.origin.y - wnd.frame.size.height * 0.5)
        wnd.setFrameOrigin(origin)
        wnd.makeKeyAndOrderFront(nil)
        NSApp.runModal(for: wnd)
        
        // 在master上 做了改变
    }
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    
    @IBAction func showTaskChain(_ sender: Any) {
        let chainWindowController = TaskChianWindowController()
        RunCenteredModal(chainWindowController.window, in: window)
    
    }
    @IBAction func showTaskTree(_ sender: Any) {
        
        let treeWindowController = TaskTreeWindowController()
        RunCenteredModal(treeWindowController.window, in: window)
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        
    }
}



extension NSView{
    
    // x
    public var x: CGFloat{
        get{
            return self.frame.origin.x
        }
        set{
            var r = self.frame
            r.origin.x = newValue
            self.frame = r
        }
    }
    
    // y
    public var y: CGFloat{
        get{
            return self.frame.origin.y
        }
        set{
            var r = self.frame
            r.origin.y = newValue
            self.frame = r
        }
    }
    
    // center frame
    public var center: NSPoint{
        get{
            return NSMakePoint(NSMidX(frame), NSMidY(frame))
        }
        set{
            var r = self.frame
            r.origin.x = newValue.x - NSMidX(r) + r.origin.x
            r.origin.y = newValue.y - NSMidY(r) + r.origin.y
            self.frame = r
        }
    }
    
    // center bounds
    public var boundsCenter:NSPoint{
        get{
            return NSPoint(x: bounds.size.width * 0.5, y: bounds.size.height * 0.5)
        }
    }
    
    //height
    public var height:CGFloat {
        set{
            var oldFrame = self.frame
            oldFrame.size.height = newValue;
            self.frame = oldFrame
        }
        get{
            return self.frame.size.height
        }
    }
    //width
    public  var width:CGFloat {
        set{
            var oldFrame = self.frame
            oldFrame.size.width = newValue;
            self.frame = oldFrame
        }
        get{
            return self.frame.size.width
        }
    }
    
    //top
    public var top:CGFloat {
        set{
            var oldFrame = self.frame
            oldFrame.origin.y = newValue;
            self.frame = oldFrame
        }
        get{
            return self.frame.origin.y
        }
    }
    //left
    public var left:CGFloat {
        set{
            var oldFrame = self.frame
            oldFrame.origin.x = newValue;
            self.frame = oldFrame
        }
        get{
            return self.frame.origin.x
        }
    }
    //bottom
    public var bottom:CGFloat {
        set{
            var oldFrame = self.frame
            oldFrame.origin.y = newValue - oldFrame.size.height;
            self.frame = oldFrame
        }
        get{
            return self.frame.origin.y + self.frame.size.height
        }
    }
    //right
    public var right:CGFloat {
        set{
            var oldFrame = self.frame
            oldFrame.origin.x = newValue+oldFrame.size.width;
            self.frame = oldFrame
        }
        get{
            return self.frame.origin.x + self.frame.size.width
        }
    }
    //size
    public var size:CGSize {
        set{
            var oldFrame = self.frame
            oldFrame.size = newValue
            self.frame = oldFrame
        }
        get{
            return self.frame.size
        }
    }
    //origin
    public var origin: CGPoint{
        set{
            var oldFrame = self.frame
            oldFrame.origin = newValue;
            self.frame = oldFrame
        }
        get{
            return self.frame.origin
        }
    }
}
