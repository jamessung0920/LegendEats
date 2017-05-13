//
//  RestaurantLoginViewController.swift
//  LegendEats
//
//  Created by 李文慈 on 2017/5/13.
//  Copyright © 2017年 宋佺儒. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RestaurantLoginViewController: UIViewController {

    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var passward: UITextField!
    
    @IBAction func login(_ sender: UIButton) {
        if self.mail.text == "" || self.passward.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            FIRAuth.auth()?.signIn(withEmail: self.mail.text!, password: self.passward.text!) { (user, error) in
                
                if error == nil {
                    
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    
                    //Go to the RecipesTableViewController if the login is sucessful
                    let vc = self.storyboard?.instantiateViewController(withIdentifier:"restaurant")
                    self.present(vc!, animated: true, completion: nil)
                    
                } else {
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}
