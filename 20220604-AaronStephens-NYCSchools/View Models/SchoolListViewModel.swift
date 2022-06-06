//
//  SchoolListViewModel.swift
//  20220604-AaronStephens-NYCSchools
//
//  Created by Aaron Stephens on 6/6/22.
//

import Foundation
import UIKit

class SchoolListViewModel {

	var schoolList: [SchoolName] {
		didSet {
			schoolListUpdated?()
		}
	}

	private var schoolListUpdated: (()->())?
	private var schoolListApi: SchoolListApi! = SchoolListApi.shared


	init() {
		schoolList = schoolListApi.schoolList
		schoolListApi.addObserver(observerKey: "schoolListViewModel") { [weak self] in
			guard let self = self else { return }
			self.schoolList = self.schoolListApi.schoolList
		}
	}

	deinit {
		schoolListUpdated = nil
	}

	func addObserver(observer: @escaping ()->()) {
		self.schoolListUpdated = observer
	}
}


// MARK: - Actions
extension SchoolListViewModel {
	func rowSelected(navigationController: UINavigationController, index: Int) {
		Router.presentSchoolDetails(navigationController: navigationController, schoolDbn: schoolList[index].dbn)
	}
}
