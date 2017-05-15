//
//  RecipesTableViewController.swift
//  Swift-TableView-Example
//
//  Created by Bilal Arslan on 28/02/16.
//  Copyright © 2016 Bilal ARSLAN. All rights reserved.
//

import UIKit
import Firebase

struct Recipe {
    let name: String
    let thumbnails: String
    let prepTime: String
}


class RecipesTableViewController: UITableViewController {
    var recipes = [Recipe]()
    let identifier: String = "tableCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
        navigationItem.title = "餐廳"
        initializeTheRecipes()
    }
    
    func initializeTheRecipes() {
        self.recipes = [Recipe(name: "李媽媽", thumbnails: "egg_benedict.jpg", prepTime: "1 hour"),
                        Recipe(name: "品客自助餐", thumbnails: "mushroom_risotto.jpg", prepTime: "30 min"),
                        Recipe(name: "豪享來", thumbnails: "full_breakfast.jpg", prepTime: "25 min"),
                        Recipe(name: "古早味", thumbnails: "hamburger.jpg", prepTime: "15 min"),
                       ]
        
        self.tableView.reloadData()
    }
    
    // MARK: UITableView DataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? TableCell
        cell.configurateTheCell(recipes[indexPath.row])
        
        cell.contentView.backgroundColor = UIColor.clear
        
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 8, width: self.view.frame.size.width - 20, height: 300))
        
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.9])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 10.0
        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 3)
        whiteRoundedView.layer.shadowOpacity = 0.2
        
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubview(toBack: whiteRoundedView)
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            recipes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }
    
    // MARK: Segue Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipeDetail" {
            let indexPath = self.tableView!.indexPathForSelectedRow
            let destinationViewController: DetailViewController = segue.destination as! DetailViewController
            destinationViewController.recipe = recipes[indexPath!.row]
        }
    }
}
