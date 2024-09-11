//
//  AsynchronousProviderTests.swift
//  VehiclesTests
//
//  Created by Ashish Patel on 2021/11/25.
//

import XCTest
@testable import Vehicles

class AsynchronousProviderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        AsynchronousProvider.reset()
        super.tearDown()
    }
    
    func testThatAsynchronousProviderRunInBackgroundUsesGlobalQueue() {
        var results: [String] = []
        let firstResult = "firstThread"
        let secondResult = "secondThread"
        let firstExpectation = expectation(description: "firstBackgroundThreadExpectation")
        let secondExpectation = expectation(description: "secondBackgroundThreadExpectation")
        
        let timeout = DispatchTime.now() + .seconds(4)
        let semaphore = DispatchSemaphore(value: 0)
        var firstJobWasSignalled = false
        
        AsynchronousProvider.runOnConcurrent {
            if semaphore.wait(timeout: timeout) != .timedOut {
                results.append(firstResult)
                firstJobWasSignalled = true
            }
            
            firstExpectation.fulfill()
        }
        
        AsynchronousProvider.runOnConcurrent {
            results.append(secondResult)
            semaphore.signal()
            secondExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            XCTAssertTrue(firstJobWasSignalled, "First job was never signalled by second job")
            XCTAssertEqual(secondResult, results.first, "Expected that the second job ran first")
            XCTAssertEqual(firstResult, results.last, "Expected that the first job ran last")
        }
    }
    
    func testThatSettingAsyncRunnerForAsynchronousProviderIsInterchangeable() {
        class AsyncRunnerMock: AsynchronousRunner {
            
            fileprivate var ranOnMain = false
            fileprivate var ranOnConcurrent = false
            
            fileprivate func runOnMain(_ action: @escaping () -> Void) {
                self.ranOnMain = true
            }
            
            fileprivate func runOnConcurrent(_ action: @escaping () -> Void) {
                self.ranOnConcurrent = true
            }
            
        }
        
        let mockAsyncRunner = AsyncRunnerMock()
        
        AsynchronousProvider.setAsyncRunner(mockAsyncRunner)
        AsynchronousProvider.runOnConcurrent {
            print("Running on background")
        }
        
        XCTAssertTrue(mockAsyncRunner.ranOnConcurrent)
        XCTAssertFalse(mockAsyncRunner.ranOnMain)
    }
    
    func testThatResettingAsynchronousProviderResetsBackToDefaultAsyncRunner() {
        class AsyncRunnerMock: AsynchronousRunner {
            fileprivate func runOnConcurrent(_ action: @escaping () -> Void) {}
            fileprivate func runOnMain(_ action: @escaping () -> Void) {}
        }
        
        let expect = expectation(description: "expectation")
        
        AsynchronousProvider.setAsyncRunner(AsyncRunnerMock())
        AsynchronousProvider.reset()
        AsynchronousProvider.runOnConcurrent {
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
}
