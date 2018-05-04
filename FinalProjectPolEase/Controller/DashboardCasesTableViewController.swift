//
//  DashboardCasesTableViewController.swift
//  FinalProjectPolEase
//
//  Created by Shamit Bhatia on 5/1/18.
//  Copyright © 2018 Shamit Bhatia. All rights reserved.
//

import UIKit
import FirebaseAuth


var myIndex = 0
var intToControlCellClick = 0

class DashboardCasesTableViewController: UITableViewController {
	
	@IBOutlet weak var myTableView: UITableView!
	
	let model: UserModel = UserModel.shared

	@IBAction func logoutButtonTap(_ sender: Any) {
		
		intToControlPopup = 0
		
		updateFB()
		
		// sign user out from auth
		let firebaseAuth = Auth.auth()
		do {
			try firebaseAuth.signOut()

		} catch let signOutError as NSError {
			print ("Error signing out: %@", signOutError)
		}
		// perform segue
		performSegue(withIdentifier: "logoutSegue", sender: sender)
		
	}
	override func viewDidLoad() {
        super.viewDidLoad()
		
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
		
		// update the user's case list from model into firebase
		
		myTableView.delegate = self
		myTableView.dataSource = self
	
    }

	override func viewDidAppear(_ animated: Bool) {
		myTableView.reloadData()
	}
	func updateFB(){
		let id = Auth.auth().currentUser?.uid
		let currUser = self.model.getUserById(uid: id!)
		print(currUser?.listOfCases as Any)
		for eachCase in (currUser?.listOfCases)!{
			let caseID = eachCase.caseID
			
			eachCase.saveCaseWithID(userID: id!, caseID: caseID)
			
		}
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
		
		let id = Auth.auth().currentUser?.uid
		let currUser = self.model.getUserById(uid: id!)
		
		return (currUser?.listOfCases.count)!
		
    }

	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

		// get the user
		let id = Auth.auth().currentUser?.uid
		let currUser = self.model.getUserById(uid: id!)
		
        // Configure the cell...
		cell.textLabel?.text = currUser?.listOfCases[indexPath.row].title
	
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

	
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
			// Delete from model and delete from firebase
			let id = Auth.auth().currentUser?.uid
			let currUser = self.model.getUserById(uid: id!)
			
			// removes from userModel
			currUser?.listOfCases.remove(at: indexPath.row)
			
            // Delete the row from the data source
            myTableView.deleteRows(at: [indexPath], with: .fade)
			
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		myIndex = indexPath.row
		intToControlCellClick = 5
		
		performSegue(withIdentifier: "tableSegue", sender: self)
		
	}
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
