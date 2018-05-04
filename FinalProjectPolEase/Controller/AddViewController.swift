//
//  AddViewController.swift
//  FinalProjectPolEase
//
//  Created by Shamit Bhatia on 5/1/18.
//  Copyright © 2018 Shamit Bhatia. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage


class AddViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

	let model: UserModel = UserModel.shared
	
	@IBAction func cancelBtn(_ sender: Any) {
		self.dismiss(animated: true, completion: nil)
	}
	
	@IBAction func saveBtn(_ sender: Any) {
		
		
		if (caseTitle.text == "" || caseDescription.text == "" || myImageView.image == nil){
			let alert = UIAlertController(title: "Fields missing", message: "Please fill out all fields before continuing", preferredStyle: .alert)
			
			alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
			
			self.present(alert, animated: true)
		}else{
			// create the case and assign to the user
		
			
//			guard let actualImage = myImageView.image else{ return }
			// upload image to firebase storage
//			self.uploadProfileImage(actualImage, completion: { (url) in
//				<#code#>
//			})
			// create new case with case URL
			guard let uid = Auth.auth().currentUser?.uid else { return }
			guard let image = myImageView.image else { return }
			
			let currUser = self.model.getUserById(uid: uid)
			let currUserNumCases = (currUser?.listOfCases.count)! + 1
			
			let storageRef = Storage.storage().reference().child("user/\(uid)/case"+String(describing: currUserNumCases))
			
			guard let imageData = UIImageJPEGRepresentation(image, 0.75) else { return }
		
			let metaData = StorageMetadata()
			
			storageRef.putData(imageData, metadata: metaData) { metaData, error in
				if error != nil{
					print(error as Any)
					return
				}else{
					storageRef.downloadURL(completion: { (url, error) in
						if error != nil {
							print(error as Any)
						} else {
							guard let imageUrlString = url?.absoluteString else { return }
							print(imageUrlString)
							let newCase = Case(title: self.caseTitle.text!, description: self.caseDescription.text!, imageString:imageUrlString)
							
							if Auth.auth().currentUser != nil {
								// User is signed in.
								
								let currUserNow = Auth.auth().currentUser
								
								
								// Get the actual user object via currUser.uid in UserModel
								let actualUserObject = self.model.getUserById(uid: (currUserNow?.uid)!)
								// Update the userModel (append this new case to the actual user object list of cases)
								actualUserObject?.listOfCases.append(newCase)
								
								// save the case to the current user database on firebase
								newCase.saveCase(id: (currUserNow?.uid)!)
								
								
							} else {
								// No user is signed in.
								
							}
						}
					})
				}
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
		
		if intToControlCellClick == 5{
			// that means you're coming from a cell click -- populate the data
			guard let uid = Auth.auth().currentUser?.uid else { return }
			let thisSpecificUser = self.model.getUserById(uid: uid)
			
			let thisSpecificCase = thisSpecificUser?.listOfCases[myIndex]
			
		
			
			caseTitle.text = thisSpecificCase?.title
			caseDescription.text = thisSpecificCase?.description
			
			// populate imageview with reference
//			let storageReference = Storage.storage().reference().child("user/\(uid)/case"+String(1))
			let storageReference = Storage.storage().reference(forURL: (thisSpecificCase?.imageString)!)
			
			storageReference.getData(maxSize: 1 * 1024 * 1024, completion: { (data, error) in
				if error != nil {
					// error
					print("UH OH")
				}
				else{
					print("OKAY")
					self.myImageView.image = UIImage(data: data!)
					
				}
			})
			
			
			intToControlCellClick = 10
		}
	
		
		
    }

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.view.endEditing(true)
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
