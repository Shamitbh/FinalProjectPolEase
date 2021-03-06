//
//  LogInTableViewController.swift
//  FinalProjectPolEase
//
//  Created by Shamit Bhatia on 5/1/18.
//  Copyright © 2018 Shamit Bhatia. All rights reserved.
//

import UIKit
import FirebaseAuth

class LogInTableViewController: UITableViewController {
	
	@IBOutlet weak var userEmailLoginText: UITextField!
	@IBOutlet weak var userPasswordLoginText: UITextField!
	
	@IBAction func loginBtn(_ sender: Any) {
		// Log in the user and display his/her cases in table view next
		if (self.userEmailLoginText.text! == "" || self.userPasswordLoginText.text! == ""){
			// One of the fields is empty -- tell user you can't log in to account without filling all fields out
			let alert = UIAlertController(title: "Fields missing", message: "Please fill out all fields before continuing", preferredStyle: .alert)
			
			alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
			
			self.present(alert, animated: true)
		}
		else{
			// TO DO - LOG IN TO USER ACCOUNT
			
			Auth.auth().signIn(withEmail: userEmailLoginText.text!, password: userPasswordLoginText.text!) { (user, error) in
				if (user != nil){
					// user successfully logged in
					print("Successfully logged in!")
					self.performSegue(withIdentifier: "loginToDash", sender: self)
				}
				else{
					print("No user found")
					let alert = UIAlertController(title: "No user found", message: "There is no user in the database with those credentials.", preferredStyle: .alert)

					alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))

					self.present(alert, animated: true)
					
				}
			}
		}
		
		
	}
	

    override func viewDidLoad() {
        super.viewDidLoad()
		intToControlPopup = 0
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.view.endEditing(true)
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
	/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
	*/
	
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
