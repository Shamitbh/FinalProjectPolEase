//
//  Case.swift
//  FinalProjectPolEase
//
//  Created by Shamit Bhatia on 4/28/18.
//  Copyright © 2018 Shamit Bhatia. All rights reserved.
//

import Foundation

class Case{
	// Properties
	var title: String
	var description: String
	var image: String // CHANGE THIS TO UIIMAGE LATER??
	
	
	
//	// Custom init
//	convenience init(studentId: String) {
//		self.init(id: studentId, firstName: "", lastName: "")
//	}
	
	init(title: String, description: String, image: String) {
		// Have to intialize all of the properties
		self.title = title
		self.description = description
		self.image = image
	}
}
