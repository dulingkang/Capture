//
//  SSTaskManager.swift
//  Capture
//
//  Created by dulingkang on 24/11/15.
//  Copyright © 2015 ShawnDu. All rights reserved.
//

import UIKit

let kCacheMark: Int = 3

class SSTaskManager: NSObject {
    
    private var undoQueue: [SSTask] = []
    private var redoQueue: [SSTask] = []
    
    override init() {
        super.init()
    }
    
    //MARK: - static method
    static func performAsync(complete: (() -> Void)) {
        let queue = dispatch_queue_create("PerformAsync", nil)
        dispatch_async(queue, complete)
    }
    
    //MARK: - public method
    func undo() -> SSTask? {
        if self.undoable() {
            if let task = self.undoQueue.last {
                self.redoQueue.append(task)
                self.undoQueue.removeLast()
                SSTaskManager.performAsync({ () -> Void in
                    if self.undoQueue.count >= kCacheMark {
                        self.undoQueue[self.undoQueue.count - kCacheMark].prepare()
                    }
                    if self.redoQueue.count > kCacheMark {
                        self.redoQueue[self.redoQueue.count - kCacheMark - 1].cache()
                    }
                })
            }

        }
        return self.undoQueue.last
    }
    
    func redo() -> SSTask? {
        if self.redoable() {
            if let task = self.redoQueue.last {
                self.undoQueue.append(task)
                self.redoQueue.removeLast()
                SSTaskManager.performAsync({ () -> Void in
                    if self.undoQueue.count > kCacheMark {
                        self.undoQueue[self.undoQueue.count - kCacheMark - 1].cache()
                    }
                    if  self.redoQueue.count >= kCacheMark {
                        self.redoQueue[self.redoQueue.count - kCacheMark].prepare()
                    }
                })
            }
        }
        return self.undoQueue.last
    }
    
    func undoable() -> Bool {
        return self.undoQueue.count > 1
    }
    
    func redoable() -> Bool {
        return self.redoQueue.count > 0
    }
    
    func lastTask() -> SSTask? {
        return self.undoQueue.last
    }
    
    func addTask(task: SSTask) -> SSTask {
        self.undoQueue.append(task)
        self.cleanRedoQueue()
        SSTaskManager.performAsync { () -> Void in
            if self.undoQueue.count > kCacheMark {
                self.undoQueue[self.undoQueue.count - kCacheMark - 1].cache()
            }
        }
        return self.undoQueue.last!
    }
    
    func reset() {
        self.cleanUndoQueue()
        self.cleanRedoQueue()
    }
    
    //MARK: - private method
    private func cleanRedoQueue() {
        if self.redoQueue.count > 0 {
            for task in self.redoQueue {
                task.clean()
            }
            self.redoQueue.removeAll()
        }
    }
    
    private func cleanUndoQueue() {
        if self.undoQueue.count > 0 {
            for task in self.undoQueue {
                task.clean()
            }
            self.undoQueue.removeAll()
        }
    }
}
