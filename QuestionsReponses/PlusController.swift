//
//  PlusController.swift
//  QuestionsReponses
//
//  Created by Eric Digbeu on 25/08/2018.
//  Copyright © 2018 ANJC Productions. All rights reserved.
//

import UIKit

class PlusController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Ref widgets
    @IBOutlet weak var tableViewPlus: UITableView!
    
    // Ref attributes
    private let menuPlus:[String] = ["Quiz terminés", "Quiz en cours", "Croissance spirituelle", "Laisser un message", "Partager l'application", "Paramètres", "Rechercher un média", "Mettre à jour l'application", "Téléchargement Youtube"]
    private let menuImagePlus:[UIImage] = [#imageLiteral(resourceName: "quiz_end_48"), #imageLiteral(resourceName: "quiz_not_end_48"), #imageLiteral(resourceName: "quiz_progress_48"), #imageLiteral(resourceName: "message_48"), #imageLiteral(resourceName: "share_48"), #imageLiteral(resourceName: "settings_48"), #imageLiteral(resourceName: "search_48"), #imageLiteral(resourceName: "updates_48"), #imageLiteral(resourceName: "download_48")]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Plus"
        tableViewPlus.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuPlus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableViewPlus.dequeueReusableCell(withIdentifier: "idPlusCell") as? PlusCell else { return UITableViewCell() }
        //cell.imagePlus.image = menuImagePlus[indexPath.row]
       // cell.labelPlusTitle.text = menuPlus[indexPath.row]
        return cell.loadDataCell(imageValue: menuImagePlus[indexPath.row], titleValue: menuPlus[indexPath.row])
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Numéro du plus sélectionné : \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
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
