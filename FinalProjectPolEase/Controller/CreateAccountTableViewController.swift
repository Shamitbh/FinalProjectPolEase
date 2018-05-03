//
//  CreateAccountTableViewController.swift
//  FinalProjectPolEase
//
//  Created by Shamit Bhatia on 5/1/18.
//  Copyright © 2018 Shamit Bhatia. All rights reserved.
//

import UIKit
import FirebaseAuth

class CreateAccountTableViewController: UITableViewController {

	let model: UserModel = UserModel.shared
	
	
	@IBOutlet weak var emailText: UITextField!
	@IBOutlet weak var fullNameText: UITextField!
	@IBOutlet weak var usernameText: UITextField!
	@IBOutlet weak var passwordText: UITextField!
	
	@IBAction func createAccountBtn(_ sender: Any) {
		if (self.emailText.text! == "" || self.fullNameText.text! == "" || self.usernameText.text! == "" || self.passwordText.text! == ""){
			// One of the fields is empty -- tell user you can't create an account without filling all fields out
			let alert = UIAlertController(title: "Fields missing", message: "Please fill out all fields before continuing", preferredStyle: .alert)
			
			alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
			
			self.present(alert, animated: true)
		}
		else{
			// TO DO - CREATE ACCOUNT FIREBASE AUTH
			Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (user, error) in
				if user != nil{
					// user succesffully created
					let newUser = User(uID: (user?.uid)!, userEmail: self.emailText.text!, userPassword: self.passwordText.text!, userFullName: self.fullNameText.text!, userUsername: self.usernameText.text!)
					
					// save to model
					self.model.addUser(user: newUser)
					print(self.model.numberOfUsers())
					
					// save to firebase
					newUser.save(id: (user?.uid)!)
					
					// go back to welcome screen
					self.performSegue(withIdentifier: "createAccToWelcome", sender: self)
					
				}
				else{
					// error
					let alert = UIAlertController(title: "Error", message: "Badly formatted email or password or user already in database", preferredStyle: .alert)
					
					alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
					
					self.present(alert, animated: true)
				}
			}
		}

	}
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
	
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

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
