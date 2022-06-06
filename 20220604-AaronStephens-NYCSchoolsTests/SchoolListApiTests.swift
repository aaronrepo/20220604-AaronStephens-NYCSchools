//
//  SchoolListApiTests.swift
//  20220604-AaronStephens-NYCSchoolsTests
//
//  Created by Aaron Stephens on 6/3/22.
//

import XCTest
@testable import _0220604_AaronStephens_NYCSchools

class SchoolListApiTests: XCTestCase {

	override func setUpWithError() throws {
		_ = SchoolListApi.shared
	}

	override func tearDownWithError() throws {
		SchoolListApi.shared.removeObserver(observerKey: "testListRetrieval")
	}

	func testListRetrieval() {
		if SchoolListApi.shared.schoolList.isEmpty {
			let expectation = XCTestExpectation(description: "Retrieve School Names")

			SchoolListApi.shared.addObserver(observerKey: "testListRetrieval") {
				XCTAssert(SchoolListApi.shared.schoolList.count == 440)
				expectation.fulfill()
			}

			wait(for: [expectation], timeout: 10)
		}
		else {
			XCTAssert(SchoolListApi.shared.schoolList.count == 440)
		}
	}
}
