//
//  AsynchronousRunnerImplementation.swift
//  Vehicles
//
//  Created by Ashish Patel on 2021/11/25.
//

/**
 ## AsynchronousRunnerImplementation
 
 This class is using to perform threading operations.
 
 */

import Foundation

public class AsynchronousRunnerImplementation: NSObject, AsynchronousRunner {
    
    /// Request to perform operation on backgroud thread
    ///   - action: callback

    public func runOnConcurrent(_ action: @escaping () -> Void) {
        DispatchQueue.global(qos: .background).async(execute: action)
    }
    
    /// Request to perform operation on main thread
    ///   - action: callback
    
    public func runOnMain(_ action: @escaping () -> Void) {
        DispatchQueue.main.async(execute: action)
    }
}
