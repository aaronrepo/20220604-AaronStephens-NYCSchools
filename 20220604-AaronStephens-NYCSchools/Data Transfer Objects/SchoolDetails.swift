//
//  SchoolDetails.swift
//  20220604-AaronStephens-NYCSchools
//
//  Created by Aaron Stephens on 6/3/22.
//

import Foundation

struct SchoolDetails {
	var dbn: String = ""
	var schoolName: String = ""
	var numOfSatTestTakers: String = ""
	var satCriticalReadingAvgScore: String = ""
	var satMathAvgScore: String = ""
	var satWritingAvgScore: String = ""

	var hasValidData: Bool {
		!(
			dbn.isEmpty ||
			schoolName.isEmpty ||
			numOfSatTestTakers.isEmpty ||
			satCriticalReadingAvgScore.isEmpty ||
			satMathAvgScore.isEmpty ||
			satWritingAvgScore.isEmpty
		)
	}

}
