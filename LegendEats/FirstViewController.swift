//
//  FirstViewController.swift
//  appproject
//
//  Created by 李文慈 on 2017/4/20.
//  Copyright © 2017年 lulu. All rights reserved.
//

import UIKit
import Firebase

class FirstViewController: UIViewController {
    
    
    
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBAction func submit(_ sender: UIButton)
    {
        data()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference().child("student")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func data()
    {
        let key = ref.childByAutoId().key
        let student = [ "student number": number.text! as String,
                        "student name": name.text! as String
                      ]
        ref.child(key).setValue(student)
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
