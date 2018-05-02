//
//  User.swift
//  FinalProjectPolEase
//
//  Created by Shamit Bhatia on 5/1/18.
//  Copyright © 2018 Shamit Bhatia. All rights reserved.
//

import Foundation
import UIKit

class User{
	// Properties
	var userEmail: String
	var userPassword: String
	var userFullName: String
	var userUsername: String
	var listOfCases: Array<Case>
	
	init(userEmail: String, userPassword: String, userFullName: String, userUsername: String, listOfCases: Array<Case>) {
		self.userEmail = userEmail
		self.userPassword = userPassword
		self.userFullName = userFullName
		self.userUsername = userUsername
		self.listOfCases = listOfCases
	}
	
	init(userEmail: String, userPassword: String){
		self.userEmail = userEmail
		self.userPassword = userPassword
		self.userFullName = ""
		self.userUsername = ""
		self.listOfCases = [Case]()
	}
}
