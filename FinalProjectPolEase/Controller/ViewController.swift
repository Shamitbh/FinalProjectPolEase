//
//  ViewController.swift
//  FinalProjectPolEase
//
//  Created by Shamit Bhatia on 4/24/18.
//  Copyright © 2018 Shamit Bhatia. All rights reserved.
//

import UIKit
import Firebase

var intToControlModel: Int = 1
var intToControlPopup: Int = 0

class ViewController: UIViewController {
	
	let model: UserModel = UserModel.shared
	
	
	var ref : DatabaseReference?
	var dbHandle: DatabaseHandle?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	
		if (intToControlModel == 1){
			// load the model from firebase to the userModel
			ref = Database.database().reference()
		
				// let userID = Auth.auth().currentUser?.uid -- child(uid)
				ref?.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
					
					if (snapshot.childrenCount > 0){
						// data exists in firebase already
						// Get user value
						let value = snapshot.value as? NSDictionary
						
						// Go through all the user's in the value snapshot with loop
						let userCountInDb = value?.count
						for index in 0..<userCountInDb!{
							// get each User's dictionary, and then get user's email, password, etc.
							let tempUserDict = value?.allValues[index] as! Dictionary<String, AnyObject>
							
							let emailTemp = tempUserDict["email"]
							
							let fullNameTemp = tempUserDict["fullName"]
							
							let passwordTemp = tempUserDict["password"]
							
							let uidTemp = tempUserDict["uid"]
							
							let usernameTemp = tempUserDict["username"]
							
							
							if (tempUserDict.count == 6){
								// that means that this user has cases
								// NEED TO GO THROUGH THIS USER and get each case, make the case into list and add to user
								// check how many cases there are with count and loop through
								let myCases = tempUserDict["cases"] as? NSDictionary
								let caseCount = myCases?.count
								
								// create empty array of cases
								var caseList: Array<Case> = [Case]()
								
								for indexTemp in 0..<caseCount!{
									let tempCaseDict = myCases?.allValues[indexTemp] as! Dictionary<String, AnyObject>
									let caseTitleTemp = tempCaseDict["caseTitle"]
									let caseDescriptionTemp = tempCaseDict["caseDescription"]
									let caseImageStringTemp = tempCaseDict["caseImageString"]
									
									let newCaseObj = Case(title: caseTitleTemp as! String, description: caseDescriptionTemp as! String, imageString: caseImageStringTemp as! String)
									caseList.append(newCaseObj)
								
								}
								
								// Now that we have our caseList, initialize the user
								let newUser = User(uID: uidTemp as! String, userEmail: emailTemp as! String, userPassword: passwordTemp as! String, userFullName: fullNameTemp as! String, userUsername: usernameTemp as! String, listOfCases: caseList)
								
								// add this user to the shared model of users
								self.model.addUser(user: newUser)
						
							}else{
								// that means this user does not have any cases
								// initialize user without any cases
								let newUser = User(uID: uidTemp as! String, userEmail: emailTemp as! String, userPassword: passwordTemp as! String, userFullName: fullNameTemp as! String, userUsername: usernameTemp as! String)
								// add this user to the shared model of users
								self.model.addUser(user: newUser)
							}
						}
					}
					else{
						// Data doesn't exist yet in firebase.
					}
					
				}) { (error) in
					print(error.localizedDescription)
				}
		
			
			// update intToControlModel so that this if stmt only happens once at start of app
			intToControlModel = intToControlModel + 1
		}
		
		
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewDidAppear(_ animated: Bool) {
		if (intToControlPopup == 10){
			
			let alert = UIAlertController(title: "User created Successfully!", message: "Now please proceed to log in.", preferredStyle: .alert)
			
			alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
			
			self.present(alert, animated: true)
		}

	}

}

