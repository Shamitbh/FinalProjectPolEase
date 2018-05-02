//
//  AddViewController.swift
//  FinalProjectPolEase
//
//  Created by Shamit Bhatia on 5/1/18.
//  Copyright © 2018 Shamit Bhatia. All rights reserved.
//

import UIKit
import FirebaseAuth

class AddViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

	@IBAction func cancelBtn(_ sender: Any) {
		self.dismiss(animated: true, completion: nil)
	}
	
	@IBAction func saveBtn(_ sender: Any) {
		
		
		if (caseTitle.text == "" || caseDescription.text == ""){
			let alert = UIAlertController(title: "Fields missing", message: "Please fill out all fields before continuing", preferredStyle: .alert)
			
			alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
			
			self.present(alert, animated: true)
		}else{
			// create the case and assign to the user
		
//			let newCase = Case(title: caseTitle.text!, description: caseDescription.text!, image: myImageView.image!)
			let newCase = Case(title: caseTitle.text!, description: caseDescription.text!, imageString: "myImageString")
			
			
			if Auth.auth().currentUser != nil {
				// User is signed in.
				print("Yes! We found the user")
				let currUser = Auth.auth().currentUser
				
				newCase.saveCase(id: (currUser?.uid)!, caseID: "Case01")
				
				// save the case to the current user database
				
				
				
			} else {
				// No user is signed in.
				print("No user signed in right now.")
			}
			
			self.dismiss(animated:true, completion: nil)
		}
		

		
		
	}
	
	@IBOutlet weak var caseTitle: UITextField!
	@IBOutlet weak var caseDescription: UITextView!
	
	@IBOutlet weak var myImageView: UIImageView!
	
	@IBAction func importImage(_ sender: Any) {
		let image = UIImagePickerController()
		image.delegate = self
		image.sourceType = UIImagePickerControllerSourceType.photoLibrary
		
		image.allowsEditing = false
		
		self.present(image, animated: true){
			
		}
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
	{
		if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
			myImageView.image = image
		}
		else{
			// error message
		}
		
		self.dismiss(animated: true, completion: nil)
	}
	
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
