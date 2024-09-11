//
//  AsynchronousProvider.swift
//  Vehicles
//
//  Created by Ashish Patel on 2021/11/25.
//

/**
 ## AsynchronousRunner
 
 This protocol is using to perform threading operations.
 
 */

import Foundation

@objc public protocol AsynchronousRunner {

    func runOnConcurrent(_ action: @escaping () -> Void)
    
    func runOnMain(_ action: @escaping () -> Void)
    
}

@objcMembers public class AsynchronousProvider: NSObject {

    private static var asyncRunner : AsynchronousRunner = AsynchronousRunnerImplementation()
    
    /**
     Run a block of code on a concurrent queue.
     
     Concurrent queues (also known as a type of global dispatch queue) execute one or more tasks
     concurrently, but tasks are still started in the order in which they were added to the queue.
     The currently executing tasks run on distinct threads that are managed by the dispatch queue.
     The exact number of tasks executing at any given point is variable and depends on system
     conditions.
     
     - parameter action: Closure to run on concurrent thread.
     */
    @objc public static func runOnConcurrent(_ action: @escaping () -> Void) {
        asyncRunner.runOnConcurrent(action)
    }
    
    @objc public static func runOnMain(_ action: @escaping () -> Void) {
        asyncRunner.runOnMain(action)
    }

    @objc public static func setAsyncRunner(_ asyncRunner: AsynchronousRunner) {
        self.asyncRunner = asyncRunner
    }
    
    @objc public static func reset() {
        asyncRunner = AsynchronousRunnerImplementation()
    }
}
