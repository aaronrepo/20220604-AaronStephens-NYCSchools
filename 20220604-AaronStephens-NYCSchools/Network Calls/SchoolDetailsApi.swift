//
//  SchoolDetailsApi.swift
//  20220604-AaronStephens-NYCSchools
//
//  Created by Aaron Stephens on 6/5/22.
//

import Foundation

class SchoolDetailsApi: NSObject {
	static let shared = SchoolDetailsApi()

	private let schoolDetailsUrl = "https://data.cityofnewyork.us/api/views/f9bf-2cp4/rows.xml?accessType=DOWNLOAD"
	private var elementName = ""
	private var schoolDetails = SchoolDetails()
	private var observers = [String: ()->()]()

	private(set) var allSchoolsDetails = [String: SchoolDetails]()

	override init() {
		super.init()
		getAllSchoolsDetails()
	}

	private func getAllSchoolsDetails() {
		guard
			let listUrl = URL(string: schoolDetailsUrl),
			let parser = XMLParser(contentsOf: listUrl)
		else {
			print("Cannot Read Data")
			return
		}

		parser.delegate = self
		if !parser.parse() {
			print("Data Errors Exist:")
			let error = parser.parserError!
			print("Error Description:\(error.localizedDescription)")
			print("Line number: \(parser.lineNumber)")
		}
	}
}

// MARK: - XMLParserDelegate
extension SchoolDetailsApi: XMLParserDelegate {
	func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
		self.elementName = elementName
	}

	func parser(_ parser: XMLParser, foundCharacters string: String) {
		switch elementName {
			case "dbn":
				let trimmedString = string.trimmingCharacters(in: .newlines)
				schoolDetails.dbn += trimmedString
			case "school_name":
				let trimmedString = string.trimmingCharacters(in: .newlines)
				schoolDetails.schoolName += trimmedString
			case "num_of_sat_test_takers":
				let trimmedString = string.trimmingCharacters(in: .newlines)
				schoolDetails.numOfSatTestTakers += trimmedString
			case "sat_critical_reading_avg_score":
				let trimmedString = string.trimmingCharacters(in: .newlines)
				schoolDetails.satCriticalReadingAvgScore += trimmedString
			case "sat_math_avg_score":
				let trimmedString = string.trimmingCharacters(in: .newlines)
				schoolDetails.satMathAvgScore += trimmedString
			case "sat_writing_avg_score":
				let trimmedString = string.trimmingCharacters(in: .newlines)
				schoolDetails.satWritingAvgScore += trimmedString
			default: return
		}
	}


	func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
		if elementName == "row" {
			guard schoolDetails.hasValidData else {
				schoolDetails = SchoolDetails()
				return
			}
			allSchoolsDetails[schoolDetails.dbn] = schoolDetails
			schoolDetails = SchoolDetails()
		}
	}

	func parserDidEndDocument(_ parser: XMLParser) {
		notifyObservers()
	}
}


// MARK: - Observer helpers
extension SchoolDetailsApi {

	func addObserver(observerKey: String, observer: @escaping ()->()) {
		observers[observerKey] = observer
	}

	func removeObserver(observerKey: String) {
		observers.removeValue(forKey: observerKey)
	}

	private func notifyObservers() {
		observers.forEach { _, observer in
			observer()
		}
	}
}
