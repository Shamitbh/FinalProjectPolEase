//
//  AddViewController.swift
//  FinalProjectPolEase
//
//  Created by Shamit Bhatia on 5/1/18.
//  Copyright © 2018 Shamit Bhatia. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

	
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
