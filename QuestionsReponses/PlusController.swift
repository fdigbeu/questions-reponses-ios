//
//  PlusController.swift
//  QuestionsReponses
//
//  Created by Eric Digbeu on 25/08/2018.
//  Copyright © 2018 ANJC Productions. All rights reserved.
//

import UIKit
import MessageUI

class PlusController: UITableViewController, MFMailComposeViewControllerDelegate {
    
    // Ref attributes
    private let menuPlus:[String] = ["Quiz terminés", "Quiz en cours", "Croissance spirituelle", "Laisser un message", "Partager l'application", "Nombre de questions", "Niveaux de difficulté", "Rechercher un média", "Mettre à jour l'application"]
    private let menuImagePlus:[UIImage] = [#imageLiteral(resourceName: "quiz_end_48"), #imageLiteral(resourceName: "quiz_not_end_48"), #imageLiteral(resourceName: "quiz_progress_48"), #imageLiteral(resourceName: "message_48"), #imageLiteral(resourceName: "share_48"), #imageLiteral(resourceName: "level_48"), #imageLiteral(resourceName: "number_question_48"), #imageLiteral(resourceName: "search_48"), #imageLiteral(resourceName: "updates_48")]
    
    let segueScoreIdentifier = "quizPlusToQuizTerminesOuNon"
    let segueGrowthIdentifier = "quizGameToCroissanceSpirit"
    
    private var daoQuiz:DAOQuiz!

    override func viewDidLoad() {
        super.viewDidLoad()
        daoQuiz = DAOQuiz()
        title = "Plus"
        self.tableView.tableFooterView = UIView()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuPlus.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "idPlusCell") as? PlusCell else { return UITableViewCell() }
        return cell.loadDataCell(imageValue: menuImagePlus[indexPath.row], titleValue: menuPlus[indexPath.row])
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Numéro du plus sélectionné : \(indexPath.row)")
        switch indexPath.row {
        case 0:  // Quiz terminés
            let allQuizzFinished = daoQuiz.getAllScoresFinished()
            if allQuizzFinished.count > 0{
                performSegue(withIdentifier: segueScoreIdentifier, sender: menuPlus[indexPath.row])
            }
            else{
               showUIAlertMessage(titre:"Aucun \(menuPlus[indexPath.row].lowercased())", message:"Vous n'avez pas de quiz terminés")
            }
        case 1:  // Quiz en cours
            let allQuizzInProgress = daoQuiz.getAllScoresInProgress()
            if allQuizzInProgress.count > 0{
                performSegue(withIdentifier: segueScoreIdentifier, sender: menuPlus[indexPath.row])
            }
            else{
                showUIAlertMessage(titre:"Aucun \(menuPlus[indexPath.row].lowercased())", message:"Vous n'avez pas de quiz en cours")
            }
        case 2:  // Croissance spirituelle
            performSegue(withIdentifier: segueGrowthIdentifier, sender: menuPlus[indexPath.row])
        case 3:  // Laisser un message
            let mailComposeViewController = configureMailController()
            if MFMailComposeViewController.canSendMail(){
                self.present(mailComposeViewController, animated: true, completion: nil)
            }
            else{
                showUIAlertMessage(titre:"Erreur d'envoi", message:"L'envoi de votre message par mail a échoué !")
            }
        case 4:  // Partager l'application
            shareApp()
        case 5:  // Nombre de questions
            showUIAlertTotalOfQuestion()
        case 6: break // Niveaux de difficulté
        case 7: break // Rechercher un média
        case 8: break // Mettre à jour l'application
        default: break
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueScoreIdentifier{
            if let newController = segue.destination as? ScoreController{
                newController.typeOfQuizSelected = sender as? String
            }
        }
        else if segue.identifier == segueGrowthIdentifier{
            if let newController = segue.destination as? GrowthSpiritController{
                newController.titleOfQuizSelected = sender as? String
            }
        }
        else{}
    }
    
    private func showUIAlertTotalOfQuestion(){
        let nsTotalQuestion = UserDefaults.standard.string(forKey: "nsTotalQuestion") ?? "10"
        let alertController = UIAlertController(title: "Nombre de questions", message: "Le nombre de questions par quiz est actuellement de \(nsTotalQuestion)", preferredStyle: .alert)
        let action10 = UIAlertAction(title: "10 Quiz", style: .default) { (action:UIAlertAction) in
            UserDefaults.standard.set("10", forKey: "nsTotalQuestion")
        }
        let action20 = UIAlertAction(title: "20 Quiz", style: .default) { (action:UIAlertAction) in
            UserDefaults.standard.set("20", forKey: "nsTotalQuestion")
        }
        alertController.addAction(action10)
        alertController.addAction(action20)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func showUIAlertMessage(titre:String, message:String){
        let alertController = UIAlertController(title: titre, message: message, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            print("Close")
        }
        alertController.addAction(actionOK)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func shareApp() {
        let items: [Any] = ["Bonjour, \nUne application de quiz sur la bible.\n", URL(string: "https://www.levraievangile.org/uploads/questions-reponses.ipa")!]
        let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(activityController, animated: true)
    }
    
    func configureMailController() -> MFMailComposeViewController {
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setSubject("Message")
        mail.setToRecipients(["postmaster@levraievangile.org"])
        mail.setMessageBody("Gloire à Jésus-Christ !", isHTML: true)
        return mail
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
