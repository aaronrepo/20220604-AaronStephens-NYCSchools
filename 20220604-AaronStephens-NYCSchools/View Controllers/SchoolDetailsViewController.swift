//
//  SchoolDetailsViewController.swift
//  20220604-AaronStephens-NYCSchools
//
//  Created by Aaron Stephens on 6/6/22.
//

import UIKit

class SchoolDetailsViewController: UIViewController {

	@IBOutlet weak var stackView: UIStackView!
	@IBOutlet weak var schoolName: UILabel!
	@IBOutlet weak var numberOfTestTakers: UILabel!
	@IBOutlet weak var mathScore: UILabel!
	@IBOutlet weak var readingScore: UILabel!
	@IBOutlet weak var writingScore: UILabel!


	var viewModel: SchoolDetailsViewModel!

	override func viewDidLoad() {
		super.viewDidLoad()

		self.navigationItem.title = "SAT Scores"
		configureView()

		viewModel.addObserver { [weak self] in
			self?.configureView()
		}
	}

	deinit {
		viewModel = nil
	}

	func configureView() {
		guard let schoolDetails = viewModel.schoolDetails else {
			schoolName.text = "Data Not Available"
			stackView.isHidden = true
			return
		}

		stackView.isHidden = false
		schoolName.text = schoolDetails.schoolName
		numberOfTestTakers.text = schoolDetails.numOfSatTestTakers
		mathScore.text = schoolDetails.satMathAvgScore
		readingScore.text = schoolDetails.satCriticalReadingAvgScore
		writingScore.text = schoolDetails.satWritingAvgScore
	}
}
