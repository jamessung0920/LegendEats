//
//  DetailViewController.swift
//  Swift-TableView-Example
//
//  Created by Bilal ARSLAN on 12/10/14.
//  Copyright (c) 2014 Bilal ARSLAN. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController, UIPickerViewDelegate {
    
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var prepTime: UILabel?
    
    var recipe: Recipe?
    
    @IBOutlet weak var lbmeal: UILabel!
    @IBOutlet weak var lbpicker: UIPickerView!
    if receipe.name == ""李媽媽""{
    var meals = ["black tea", "green tea", "milk tea"]
    }

   // @IBAction func submit(_ sender: UIButton) {
     //   data()
    //}
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = recipe?.name
        imageView?.image = UIImage(named: recipe!.thumbnails)
        nameLabel?.text = recipe!.name
        prepTime?.text = "Prep Time: " + recipe!.prepTime
        
        lbpicker.delegate = self

    }
    //func data()
    //{
      //  let key = ref.childByAutoId().key
        //let student = [ "student number": number.text! as String,
          //              "student name": name.text! as String,
            //            "meal":meal.text! as String
       // ]
       // ref.child(key).setValue(student)
        //ref.child("student").child().setValue(["student name": "fuck"])
        
   // }

    func numberOfComponent(in pickerView: UIPickerView) ->Int
    {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) ->Int
    {
        return meals.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent: Int) ->String?
    {
        return meals[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        lbmeal.text = meals[row]
    }

}
