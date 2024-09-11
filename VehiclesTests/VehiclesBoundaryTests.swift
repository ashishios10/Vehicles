//
//  VehiclesBoundaryTests.swift
//  VehiclesTests
//
//  Created by Ashish Patel on 2021/11/25.
//

import XCTest
@testable import Vehicles

class VehiclesBoundaryTests: XCTestCase {

    private var vehiclesBoundaryUnderTest: VehiclesBoundary!
    private let mockNetworkEngine = MockNetworkEngine()

    override func setUp() {
        super.setUp()
        AsynchronousProvider.setAsyncRunner(DummyAsynchronousRunner())
        vehiclesBoundaryUnderTest = VehiclesInteractor(networkManger:NetworkManager(engine: mockNetworkEngine))
    }
    
    override func tearDown() {
        XCTAssertTrue(mockNetworkEngine.verify())
        AsynchronousProvider.reset()
        mockNetworkEngine.resetCounts()
    }
    
    func testsFetchTaxiesWhichReturnsInvalidResponse() {
        let expectedErrorMessage = "Unable to find records"
        let exptedError = TestDataGenerator.getGenerateError(messsage: expectedErrorMessage)
        mockNetworkEngine.expectPerformRequest(data: nil, error: exptedError)
        vehiclesBoundaryUnderTest.fetchTaxies { reponse, errorMessage in
            XCTAssertNil(reponse)
            XCTAssertEqual(expectedErrorMessage, errorMessage)
        }
    }
   
    func testsFetchTaxiesWhichReturnsValidResponse() {
        mockNetworkEngine.expectPerformRequest(data: TestDataGenerator.getMockData(), error: nil)
        vehiclesBoundaryUnderTest.fetchTaxies { reponse, errorMessage in
            XCTAssertNil(errorMessage)
            XCTAssertNotNil(reponse)
        }
    }

}
