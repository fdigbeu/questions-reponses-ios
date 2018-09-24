//
//  ExplicationController.swift
//  QuestionsReponses
//
//  Created by Eric Digbeu on 06/09/2018.
//  Copyright © 2018 ANJC Productions. All rights reserved.
//

import UIKit

class ExplicationController: UITableViewController {
    
    var explicationSelected:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Explication"
        self.tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "idExplicationCell") as? ExplicationCell else { return UITableViewCell() }
        //--
        if let explication = explicationSelected{
            return cell.loadDataCell(titleValue: explication)
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
