//
//  SchoolName.swift
//  20220604-AaronStephens-NYCSchools
//
//  Created by Aaron Stephens on 6/3/22.
//

import Foundation

struct SchoolName {
	var dbn: String = ""
	var schoolName: String = ""

	var hasValidData: Bool { !(dbn.isEmpty || schoolName.isEmpty) }
}
