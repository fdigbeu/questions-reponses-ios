//
//  QuizViewController.swift
//  QuestionsReponses
//
//  Created by Eric Digbeu on 25/08/2018.
//  Copyright © 2018 ANJC Productions. All rights reserved.
//

import UIKit

class QuizController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // Ref widgets
    @IBOutlet weak var tableViewQuiz: UITableView!
    @IBOutlet weak var viewQuizItem: UIView!
    
    // Ref attributes
    let menuQuizz:[String] = ["Toute la Bible", "Torah (Loi)", "Nevi'im (Prophètes)", "Ketouvim (Écrits)", "Évangiles", "Testament de Jésus"]
    let segueIdentifier = "quizMenuToQuizGame"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Quiz"
        tableViewQuiz.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuQuizz.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableViewQuiz.dequeueReusableCell(withIdentifier: "idQuizCell") as? QuizCell else { return UITableViewCell() }
        return cell.loadDataCell(itemValue: menuQuizz[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Numéro du quiz sélectionné : \(indexPath.row)")
        performSegue(withIdentifier: segueIdentifier, sender: menuQuizz[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
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
