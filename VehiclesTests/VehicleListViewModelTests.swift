//
//  VehicleListViewModelTests.swift
//  VehiclesTests
//
//  Created by Ashish Patel on 2021/11/25.
//

import XCTest
@testable import Vehicles

class VehicleListViewModelTests: XCTestCase {
    private var viewModelUnderTest: VehicleListViewModel!
    private let mockVehicleListDelegate = MockVehicleListDelegate()
    private let mockVehiclesBoundary = MockVehiclesBoundary()
    private let mockReverseGeocodingBoundary = MockReverseGeocodingBoundary()

    override func setUp() {
        super.setUp()
        AsynchronousProvider.setAsyncRunner(DummyAsynchronousRunner())
        viewModelUnderTest = VehicleListViewModel(delegate: mockVehicleListDelegate, vehiclesBoundary: mockVehiclesBoundary, reverseGeoBoundary: mockReverseGeocodingBoundary)
    }
    
    override func tearDown() {
        XCTAssertTrue(mockVehicleListDelegate.verify())
        XCTAssertTrue(mockVehiclesBoundary.verify())
        XCTAssertTrue(mockReverseGeocodingBoundary.verify())
        
        mockVehicleListDelegate.resetCounts()
        mockVehiclesBoundary.resetCounts()
        mockReverseGeocodingBoundary.resetCounts()
        AsynchronousProvider.reset()
    }


    func testGetUserAddressWhichReturnsTheValidAddress() {
        let exptedAddress = "Hamburg, Germany"
        self.mockReverseGeocodingBoundary.expectfetchAddress(address: exptedAddress, error: nil)
        self.mockVehicleListDelegate.expectUpdateViewTitle()
        self.viewModelUnderTest.getUserAddress()
    }
    
    func testGetUserAddressWhichThrowsError() {
        let exptedError = TestDataGenerator.getGenerateError(messsage: "Unable to find address")
        self.mockReverseGeocodingBoundary.expectfetchAddress(address: "", error: exptedError)
        self.viewModelUnderTest.getUserAddress()
    }
    
    func testGetAllNearbyTaxiesWhichReturnTheValidResponse() {
        self.mockVehicleListDelegate.expectShowLoader()
        self.mockVehicleListDelegate.expectDismissLoader()
        self.mockVehicleListDelegate.expectUpdateVehicleContent()
        self.mockVehiclesBoundary.expectFetchTaxies(vehicles: TestDataGenerator.getDummyVehicleModelContract(), errorMessage: nil)
        self.viewModelUnderTest.getAllNearbyTaxies()
        TestDataGenerator.executeRunLoop()
    }
    
    func testGetAllNearbyTaxiesWhichThrowsError() {
        let exptedError = TestDataGenerator.getGenerateError(messsage: "Unable to fetch taxies")
        self.mockVehicleListDelegate.expectShowLoader()
        self.mockVehicleListDelegate.expectDismissLoader()
        self.mockVehicleListDelegate.expectShowToast()
        self.mockVehiclesBoundary.expectFetchTaxies(vehicles: nil, errorMessage: exptedError?.localizedDescription)
        self.viewModelUnderTest.getAllNearbyTaxies()
        TestDataGenerator.executeRunLoop()
    }

}
