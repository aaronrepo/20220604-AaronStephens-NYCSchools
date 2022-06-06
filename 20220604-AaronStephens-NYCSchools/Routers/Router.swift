//
//  Router.swift
//  20220604-AaronStephens-NYCSchools
//
//  Created by Aaron Stephens on 6/6/22.
//

import UIKit

enum Router {

	static func presentSchoolDetails(navigationController: UINavigationController, schoolDbn: String) {
		let viewModel = SchoolDetailsViewModel(schoolDbn: schoolDbn)
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let schoolDetailsViewController = storyboard.instantiateViewController(withIdentifier: "SchoolDetailsViewController") as! SchoolDetailsViewController
		schoolDetailsViewController.viewModel = viewModel

		navigationController.pushViewController(schoolDetailsViewController, animated: true)
	}
}

