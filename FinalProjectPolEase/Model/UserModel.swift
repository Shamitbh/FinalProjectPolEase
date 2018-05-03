//
//  UserModel.swift
//  FinalProjectPolEase
//
//  Created by Shamit Bhatia on 5/2/18.
//  Copyright © 2018 Shamit Bhatia. All rights reserved.
//

import Foundation

class UserModel {
	// Properties
	var users : [User] // Array of users
	
	// singleton
	static var shared = UserModel()
	
	init() {
		// empty array of users at start
		users = [User]()
	}
	
	func numberOfUsers() -> Int {
		return users.count
	}
	
	func addUser(user: User){
		users.append(user)
	}
	
	func removeUser() {
		users.removeLast()
	}
	
	func getUserById(uid: String) -> User? {
		for userObject in users{
			if userObject.uID == uid{
				return userObject
			}
		}
		// didnt find user
		return nil
	}
}
