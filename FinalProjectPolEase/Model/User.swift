//
//  User.swift
//  FinalProjectPolEase
//
//  Created by Shamit Bhatia on 5/1/18.
//  Copyright © 2018 Shamit Bhatia. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class User{
	// Properties
	var uID: String
	var userEmail: String
	var userPassword: String
	var userFullName: String
	var userUsername: String
	var listOfCases: Array<Case>
	
	init(uID: String, userEmail: String, userPassword: String, userFullName: String, userUsername: String, listOfCases: Array<Case>) {
		self.uID = uID
		self.userEmail = userEmail
		self.userPassword = userPassword
		self.userFullName = userFullName
		self.userUsername = userUsername
		self.listOfCases = listOfCases
	}
	
	init(uID: String, userEmail: String, userPassword: String, userFullName: String, userUsername: String) {
		self.uID = uID
		self.userEmail = userEmail
		self.userPassword = userPassword
		self.userFullName = userFullName
		self.userUsername = userUsername
		self.listOfCases = [Case]()
	}
	
	init(userEmail: String, userPassword: String){
		self.uID = ""
		self.userEmail = userEmail
		self.userPassword = userPassword
		self.userFullName = ""
		self.userUsername = ""
		self.listOfCases = [Case]()
	}
	
	// convert user info to dictionary to save to firebase

	func toDictionary() -> [String: Any] {
		return [
			"uid" : uID,
			"username" : userUsername,
			"fullName" : userFullName,
			"email" : userEmail,
			"password" : userPassword,
			"cases" : []
		]
	}
	
	// save function to save to database w/ reference
	func save(id: String) {

		var ref: DatabaseReference!

		ref = Database.database().reference().child("users").child(id)
		
		ref.setValue(toDictionary())
	}
	
	
	
}
