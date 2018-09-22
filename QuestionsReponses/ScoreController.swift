//
//  ScoreController.swift
//  QuestionsReponses
//
//  Created by Eric Digbeu on 22/09/2018.
//  Copyright © 2018 ANJC Productions. All rights reserved.
//

import UIKit

class ScoreController: UITableViewController {
    
    var typeOfQuizSelected:String? // Quiz terminés, Quiz en cours
    private var allQuiz = [Quiz]()
    private var daoQuiz:DAOQuiz!
    private var imageIcone:UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        if typeOfQuizSelected != nil{
            title = typeOfQuizSelected!
            daoQuiz = DAOQuiz()
            if typeOfQuizSelected! == "Quiz en cours"{
                allQuiz = daoQuiz.getAllScoresInProgress()
                imageIcone = #imageLiteral(resourceName: "quiz_not_end_48")
            }
            else{
                allQuiz = daoQuiz.getAllScoresFinished()
                imageIcone = #imageLiteral(resourceName: "quiz_end_48")
            }
            print("========================== TOTAL = \(allQuiz.count) ==========================")
            self.tableView.tableFooterView = UIView()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }*/

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allQuiz.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "idScoreCell") as? ScoreCell else { return UITableViewCell() }
        let quiz = allQuiz[indexPath.row]
        return cell.loadDataCell(imageValue:imageIcone, titleValue:quiz.getCategorie, dateValue:quiz.getDate, totalTrouve:quiz.getTotalTrouve, totalQuestion:quiz.getTotalQuestion)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Numéro du score sélectionné : \(indexPath.row)")
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
