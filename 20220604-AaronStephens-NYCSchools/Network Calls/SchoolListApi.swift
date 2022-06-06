//
//  SchoolListApi.swift
//  20220604-AaronStephens-NYCSchools
//
//  Created by Aaron Stephens on 6/2/22.
//

import Foundation

class SchoolListApi: NSObject {
	static let shared = SchoolListApi()

	private let schoolListUrl = "https://data.cityofnewyork.us/api/views/s3k6-pzi2/rows.xml?accessType=DOWNLOAD"
	private var elementName = ""
	private var schoolName = SchoolName()
	private var observers = [String: ()->()]()

	private(set) var schoolList = [SchoolName]()

	override init() {
		super.init()
		getSchoolList()
	}

	private func getSchoolList() {
		guard
			let listUrl = URL(string: schoolListUrl),
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
extension SchoolListApi: XMLParserDelegate {
	func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
		self.elementName = elementName
	}

	func parser(_ parser: XMLParser, foundCharacters string: String) {
		switch elementName {
			case "dbn":
				let trimmedString = string.trimmingCharacters(in: .newlines)
				schoolName.dbn += trimmedString
			case "school_name":
				let trimmedString = string.trimmingCharacters(in: .newlines)
				schoolName.schoolName += trimmedString
			default: return
		}
	}

	func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
		if elementName == "row" {
			guard schoolName.hasValidData else {
				schoolName = SchoolName()
				return
			}
			schoolList.append(schoolName)
			schoolName = SchoolName()
		}
	}

	func parserDidEndDocument(_ parser: XMLParser) {
		notifyObservers()
	}
}


// MARK: - Observer helpers
extension SchoolListApi {

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
