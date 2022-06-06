//
//  SchoolListViewModelTests.swift
//  20220604-AaronStephens-NYCSchoolsTests
//
//  Created by Aaron Stephens on 6/6/22.
//

import XCTest
@testable import _0220604_AaronStephens_NYCSchools

class SchoolListViewModelTests: XCTestCase {

	override func setUpWithError() throws {
		_ = SchoolListApi.shared
	}

	override func tearDownWithError() throws {
		SchoolListApi.shared.removeObserver(observerKey: "schoolListViewModel")
	}

	func testSchoolListVar() {
		let schoolListViewModel = SchoolListViewModel()
		XCTAssert(schoolListViewModel.schoolList.count == 440)
	}
}
