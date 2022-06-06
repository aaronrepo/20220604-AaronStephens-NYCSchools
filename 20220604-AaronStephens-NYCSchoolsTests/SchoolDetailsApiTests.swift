//
//  SchoolDetailsApiTests.swift
//  20220604-AaronStephens-NYCSchoolsTests
//
//  Created by Aaron Stephens on 6/5/22.
//

import XCTest
@testable import _0220604_AaronStephens_NYCSchools

class SchoolDetailsApiTests: XCTestCase {

	override func setUpWithError() throws {
		_ = SchoolDetailsApi.shared
	}

	override func tearDownWithError() throws {
		SchoolDetailsApi.shared.removeObserver(observerKey: "testDetailsRetrieval")
	}

	func testDetailsRetrieval() {
		if SchoolListApi.shared.schoolList.isEmpty {
			let expectation = XCTestExpectation(description: "Retrieve School Details")

			SchoolDetailsApi.shared.addObserver(observerKey: "testListRetrieval") {
				XCTAssert(SchoolDetailsApi.shared.allSchoolsDetails.count == 478)
				expectation.fulfill()
			}

			wait(for: [expectation], timeout: 10)
		}
		else {
			XCTAssert(SchoolDetailsApi.shared.allSchoolsDetails.count == 478)
		}
	}
}
