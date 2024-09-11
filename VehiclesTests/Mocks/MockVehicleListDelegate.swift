//
//  MockVehicleListDelegate.swift
//  VehiclesTests
//
//  Created by Ashish Patel on 2021/11/25.
//

import Foundation

@testable import Vehicles

class MockVehicleListDelegate: NSObject {
    
    var count: Int = 0
    
    func expectShowToast() {
        self.count += 1
    }
    
    func expectShowLoader() {
        self.count += 1
    }

    func expectDismissLoader() {
        self.count += 1
    }
    
    func expectUpdateVehicleContent(){
        self.count += 1
    }

    func expectUpdateViewTitle(){
        self.count += 1
    }
    
    func verify() -> Bool {
        return count == 0
    }
    
    func resetCounts() {
        count = 0
    }
}


extension MockVehicleListDelegate: VehicleListDelegate {
    func showToast(_ message: String!) {
        self.count -= 1
    }
    
    func showLoader() {
        self.count -= 1
    }

    func dismissLoader() {
        self.count -= 1
    }
    
    func updateVehicleContent() {
        self.count -= 1
    }

    func updateViewTitle(_ title: String!) {
        self.count -= 1
    }
}
