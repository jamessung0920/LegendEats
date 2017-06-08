//
//  LoginViewController.swift
//  FirebaseTutorial
//
//  Created by James Dacombe on 16/11/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    var blockStudentNumberArray = [String]()
    
//Outlets
@IBOutlet weak var emailTextField: UITextField!
@IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
                super.viewDidLoad()
                    ref2 = FIRDatabase.database().reference().child("blockstudent")
                let query_block = ref2.queryOrdered(byChild: "student number")
            query_block.observe(FIRDataEventType.value, with:{(snapshot) in
                    if snapshot.childrenCount > 0
                    {
                    for blockstudent in snapshot.children.allObjects as![FIRDataSnapshot]
                        {
                            let Object = blockstudent.value as? [String: AnyObject]
                            let blockStudentNumber = Object?["student number"] as! String?
                            self.blockStudentNumberArray.append(blockStudentNumber!)
                            print(self.blockStudentNumberArray)
                        }
                    }
                })
        }
    //Login Action
    @IBAction func loginAction(_ sender: AnyObject) {
        
        if self.emailTextField.text == "" || self.passwordTextField.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        else
        {
            
            FIRAuth.auth()?.signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                
                if error == nil {
                    
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    
                    //Go to the RecipesTableViewController if the login is sucessful
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBar")
                    self.present(vc!, animated: true, completion: nil)
                    
                } else {
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            if self.blockStudentNumberArray.contains(self.emailTextField.text!)
            {
                    let alertController = UIAlertController(title: "Error", message: "Your account have been blocked!!", preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
