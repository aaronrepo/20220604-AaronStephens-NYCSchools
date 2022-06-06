//
//  SchoolDetailsViewModel.swift
//  20220604-AaronStephens-NYCSchools
//
//  Created by Aaron Stephens on 6/6/22.
//

import Foundation

class SchoolDetailsViewModel {
	private let schoolDbn: String

	private var schoolDetailsApi: SchoolDetailsApi! = SchoolDetailsApi.shared

	var schoolDetails: SchoolDetails? {
		schoolDetailsApi.allSchoolsDetails[schoolDbn]
	}

	private var schoolDetailsUpdated: (()->())?


	init(schoolDbn: String) {
		self.schoolDbn = schoolDbn

		schoolDetailsApi.addObserver(observerKey: "schoolDetailsViewModel") { [weak self] in
			self?.schoolDetailsUpdated?()
		}
	}

	deinit {
		schoolDetailsUpdated = nil
	}

	func addObserver(observer: @escaping ()->()) {
		self.schoolDetailsUpdated = observer
	}
}
