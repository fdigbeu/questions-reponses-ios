//
//  QuizViewController.swift
//  QuestionsReponses
//
//  Created by Eric Digbeu on 25/08/2018.
//  Copyright © 2018 ANJC Productions. All rights reserved.
//

import UIKit

class QuizController: UITableViewController {
    // Ref widgets
    //@IBOutlet weak var tableViewQuiz: UITableView!
    //@IBOutlet weak var viewQuizItem: UIView!
    
    // Ref attributes
    let menuQuizz:[String] = ["Toute la Bible", "Torah (Loi)", "Nevi'im (Prophètes)", "Ketouvim (Écrits)", "Évangiles", "Testament de Jésus"]
    let segueIdentifier = "quizMenuToQuizGame"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Quiz"
        self.tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuQuizz.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "idQuizCell") as? QuizCell else { return UITableViewCell() }
        return cell.loadDataCell(itemValue: menuQuizz[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Numéro du quiz sélectionné : \(indexPath.row)")
        performSegue(withIdentifier: segueIdentifier, sender: menuQuizz[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier{
            if let newController = segue.destination as? QuizGameController{
                newController.quizMenuSelected = sender as? String
            }
        }
    }

}
