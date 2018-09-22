//
//  GrothSpiritController.swift
//  QuestionsReponses
//
//  Created by Eric Digbeu on 22/09/2018.
//  Copyright © 2018 ANJC Productions. All rights reserved.
//

import UIKit

class GrowthSpiritController: UITableViewController {
    
    // Ref attributes
    var titleOfQuizSelected:String?
    private let menuGrowth:[String] = ["Niveau 1", "Niveau 2", "Niveau 3", "Niveau 4", "Niveau 5", "Niveau 6", "Niveau 7"]
    private let menuImageGrowth:[UIImage] = [#imageLiteral(resourceName: "star_bronze_48"), #imageLiteral(resourceName: "star_bronze_48"), #imageLiteral(resourceName: "star_bronze_48"), #imageLiteral(resourceName: "star_bronze_48"), #imageLiteral(resourceName: "star_silver_48"), #imageLiteral(resourceName: "star_silver_48"), #imageLiteral(resourceName: "star_or_48")]

    override func viewDidLoad() {
        super.viewDidLoad()
        if titleOfQuizSelected != nil{
            title = titleOfQuizSelected!
            self.tableView.tableFooterView = UIView()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
   /* override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }*/

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuGrowth.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "idGrowthSpiritCell") as? GrowthSpiritCell else { return UITableViewCell() }
        print("========================== \(menuGrowth[indexPath.row]) ==========================")
        return cell.loadDataCell(imageValue: menuImageGrowth[indexPath.row], titleValue: menuGrowth[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Numéro du niveau sélectionné : \(indexPath.row)")
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
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
