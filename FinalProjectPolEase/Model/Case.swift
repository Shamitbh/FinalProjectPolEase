//
//  Case.swift
//  FinalProjectPolEase
//
//  Created by Shamit Bhatia on 4/28/18.
//  Copyright © 2018 Shamit Bhatia. All rights reserved.
//

import Foundation
import UIKit


class Case{
	// Properties
	var title: String
	var description: String
	var image: UIImage
	var imageString: String
	
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
	}
}
