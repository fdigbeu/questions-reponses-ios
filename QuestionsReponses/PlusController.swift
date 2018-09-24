//
//  PlusController.swift
//  QuestionsReponses
//
//  Created by Eric Digbeu on 25/08/2018.
//  Copyright © 2018 ANJC Productions. All rights reserved.
//

import UIKit
import MessageUI

class PlusController: UIViewController, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate {
    
    // Ref widgets
    @IBOutlet weak var tableViewPlus: UITableView!
    
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
            sendEmail()
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
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
        if MFMessageComposeViewController.canSendText() {
            let sms = MFMessageComposeViewController()
            sms.messageComposeDelegate = (self as! MFMessageComposeViewControllerDelegate)
            sms.recipients = []
            sms.body = "Bonjour, \nBible quiz: https://www.levraievangile.org/uploads/questions-reponses.ipa"
            present(sms, animated: true, completion: nil)
        } else {
            // show failure alert
            showUIAlertMessage(titre:"Erreur d'envoi", message:"L'envoi de votre message par sms a échoué !")
        }
    }
    
    private func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["contact@levraievangile.org"])
            mail.setMessageBody("Gloire à Jésus-Christ !", isHTML: true)
            present(mail, animated: true)
        } else {
            // show failure alert
            showUIAlertMessage(titre:"Erreur d'envoi", message:"L'envoi de votre message par mail a échoué !")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }

}
