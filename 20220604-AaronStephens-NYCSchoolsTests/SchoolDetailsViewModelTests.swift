//
//  SchoolDetailsViewModelTests.swift
//  20220604-AaronStephens-NYCSchoolsTests
//
//  Created by Aaron Stephens on 6/6/22.
//

import XCTest
@testable import _0220604_AaronStephens_NYCSchools

class SchoolDetailsViewModelTests: XCTestCase {

	override func setUpWithError() throws {
		_ = SchoolDetailsApi.shared
	}

	override func tearDownWithError() throws {
		SchoolDetailsApi.shared.removeObserver(observerKey: "schoolDetailsViewModel")
	}

	func testSchoolListVar() {
		let schoolDetailsViewModel = SchoolDetailsViewModel(schoolDbn: "01M292")
		XCTAssert(schoolDetailsViewModel.schoolDetails?.schoolName == "HENRY STREET SCHOOL FOR INTERNATIONAL STUDIES")
	}
}
