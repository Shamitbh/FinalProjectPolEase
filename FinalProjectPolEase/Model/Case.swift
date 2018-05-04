//
//  Case.swift
//  FinalProjectPolEase
//
//  Created by Shamit Bhatia on 4/28/18.
//  Copyright © 2018 Shamit Bhatia. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class Case{
	// Properties
	var title: String
	var description: String
	var image: UIImage
	var imageString: String
	var caseID: String
	
//	// Custom init
//	convenience init(studentId: String) {
//		self.init(id: studentId, firstName: "", lastName: "")
//	}
	
	init(title: String, description: String, image: UIImage) {
		// Have to intialize all of the properties
		self.title = title
		self.description = description
		self.image = image
		// Remeber to initialize imageString for data
		self.imageString = ""
		self.caseID = ""
	}
	
	init(title: String, description: String, imageString: String) {
		// Have to intialize all of the properties
		self.title = title
		self.description = description
		self.image = UIImage()
		// Remeber to initialize imageString for data
		self.imageString = imageString
		self.caseID = ""
	}
	
	func toDictionary() -> [String: Any] {
		return [
			"caseTitle" : title,
			"caseDescription" : description,
			"caseImageString" : imageString,
			"caseID" : caseID
		]
	}
	
	
	func saveCase(id: String){
		
		var ref: DatabaseReference!
		
		ref = Database.database().reference().child("users").child(id).child("cases").childByAutoId()
		self.caseID = ref.key
		
		ref.setValue(toDictionary())
	}
	
	
	func saveCaseWithID(userID: String, caseID: String){
		var ref: DatabaseReference!
		
		ref = Database.database().reference().child("users").child(userID).child("cases").child(caseID)
		
		ref.setValue(toDictionary())
	}
}
