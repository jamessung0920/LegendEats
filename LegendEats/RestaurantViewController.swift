//
//  RestaurantViewController.swift
//  LegendEats
//
//  Created by 李文慈 on 2017/5/13.
//  Copyright © 2017年 宋佺儒. All rights reserved.
//

import UIKit
import Firebase


class RestaurantViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    var sheet = [refModel]()

    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sheet.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! ViewControllerTableViewCell
        let sheetdata: refModel
        sheetdata = sheet[indexPath.row]
        cell.getemaillb.text = sheetdata.email
        cell.getmeallb.text = sheetdata.meal
        cell.getcountlb.text = sheetdata.count
        cell.getnotelb.text = ""
        return cell
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let query = FIRDatabase.database().reference().child("student").queryOrdered(byChild:"餐廳名稱").queryEqual(toValue: "李媽媽")
        query.observe(FIRDataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount>0
            {
                self.sheet.removeAll()
                for student in snapshot.children.allObjects as![FIRDataSnapshot]
                {
                    let sheetOjbect = student.value as? [String: AnyObject]
                    let sheetemail = sheetOjbect?["學號信箱"] as! String?
                    let sheetmeal = sheetOjbect?["meal"] as! String?
                    let sheetcount = sheetOjbect?["數量"] as! String?
                    let sheettime = sheetOjbect?["訂購時間"] as! String?
                    let sheetdata = refModel(email: sheetemail, meal: sheetmeal, count: sheetcount, time: sheettime)
                    self.sheet.append(sheetdata)
                }
                
                self.table.reloadData()
            }
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let black = UITableViewRowAction(style: .default, title: "黑名單") {(action, index) in
            let alertController = UIAlertController(title:"確定要將這位同學加入黑名單嗎？", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.destructive, handler: {action in
                self.sheet.remove(at: indexPath.row)
                self.table.deleteRows(at: [indexPath], with: .fade)

            }))
            alertController.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler:nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
        black.backgroundColor = UIColor.black
        let done = UITableViewRowAction(style: .destructive, title: "完成") {(action, index) in
            self.sheet.remove(at: indexPath.row)
            self.table.deleteRows(at: [indexPath], with: .fade)
        }
        done.backgroundColor = UIColor.red

       
        return[done, black]
    }
}
