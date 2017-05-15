//
//  DetailViewController.swift
//  Swift-TableView-Example
//
//  Created by Bilal ARSLAN on 12/10/14.
//  Copyright (c) 2014 Bilal ARSLAN. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class DetailViewController: UIViewController, UIPickerViewDelegate {
    
    @IBOutlet weak var stepper: GMStepper!
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var prepTime: UILabel?
    
    var recipe: Recipe?
    var studentId: String = (FIRAuth.auth()?.currentUser?.email)!
    var result: String?
    
    @IBOutlet weak var note: UITextField!
    @IBOutlet weak var lbmeal: UILabel!
    @IBOutlet weak var lbpicker: UIPickerView!
    var meals = [String]()
    
    @IBAction func submit(_ sender: UIButton)
    {
        if lbmeal.text! == "--請下拉選擇餐點--" || stepper.value == 0.0
        {
            let alertController = UIAlertController(title:"尚未完成訂餐", message:"返回訂餐", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "ok!!", style: UIAlertActionStyle.default, handler:nil))
            present(alertController, animated: true, completion: nil)
        }
        else
        {
            data()
            let alertController = UIAlertController(title:"訂餐完成", message:"祝您用餐愉快", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "ok!!", style: UIAlertActionStyle.default, handler:nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = recipe?.name
        imageView?.image = UIImage(named: recipe!.thumbnails)
        nameLabel?.text = recipe!.name
        prepTime?.text = "Prep Time: " + recipe!.prepTime
        lbpicker.delegate = self
        stepper.addTarget(self, action: #selector(DetailViewController.stepperValueChanged), for: .valueChanged)
        ref = FIRDatabase.database().reference().child("student")
        
        //當前系統日期
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        result = formatter.string(from: date)
        
        if nameLabel?.text == "李媽媽"
        {
            meals = ["--請下拉選擇餐點--","麵", "飯"]
        }
        else if nameLabel?.text == "品客自助餐"
        {
            meals = ["--請下拉選擇餐點--","排骨", "雞腿"]
        }
        else if nameLabel?.text == "豪享來"
        {
            meals = ["--請下拉選擇餐點--","炒泡麵", "炒意麵"]
        }
        else if nameLabel?.text == "古早味"
        {
            meals = ["--請下拉選擇餐點--","滷肉飯", "雞肉飯"]
        }
    }
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
    func stepperValueChanged(stepper: GMStepper) {
        print(stepper.value, terminator: "")
    }
    func data()
    {
        let key = ref.childByAutoId().key
        let student: [String: Any] = [
            "學號信箱":studentId,
            "餐廳名稱":nameLabel?.text,
            "餐點":lbmeal.text! as String,
            "數量":String(Int(stepper.value)) as String,
            "訂購時間":result,
            "備註":note.text! as String
        ]
        ref.child(key).setValue(student)
    }
  
    
}
