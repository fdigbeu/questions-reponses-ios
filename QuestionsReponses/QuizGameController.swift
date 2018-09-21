//
//  QuizGameController.swift
//  QuestionsReponses
//
//  Created by Eric Digbeu on 05/09/2018.
//  Copyright © 2018 ANJC Productions. All rights reserved.
//

import UIKit

class QuizGameController: UITableViewController {
    
    // Ref widgets
    @IBOutlet var quizGameTableView: UITableView!

    @IBOutlet weak var cellScore: UITableViewCell!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelNumeroQuestion: UILabel!
    @IBOutlet weak var labelNote: UILabel!
    @IBOutlet weak var labelReponsesTrouvees: UILabel!
    @IBOutlet weak var imageEtoile1: UIImageView!
    @IBOutlet weak var imageEtoile2: UIImageView!
    @IBOutlet weak var imageEtoile3: UIImageView!
    @IBOutlet weak var imageEtoile4: UIImageView!
    @IBOutlet weak var imageEtoile5: UIImageView!
    @IBOutlet weak var imageEtoile6: UIImageView!
    @IBOutlet weak var imageEtoile7: UIImageView!
    @IBOutlet weak var imageEtoile8: UIImageView!
    @IBOutlet weak var imageEtoile9: UIImageView!
    @IBOutlet weak var imageEtoile10: UIImageView!
    
    @IBOutlet weak var cellRepExplication: UITableViewCell!
    @IBOutlet weak var labelReponse: UILabel!
    @IBOutlet weak var buttonExplication: UIButton!
    @IBAction func btnExplication(_ sender: Any) {
        if allQuizzAnswered.index(forKey: numeroQuestion!) != nil{
            let quizSaved = allQuizzAnswered[numeroQuestion!]!
            performSegue(withIdentifier: segueIdentifier, sender: quizSaved.getExplication)
        }
    }
    
    @IBOutlet weak var cellQuestion: UITableViewCell!
    @IBOutlet weak var labelQuestion: UILabel!
    
    @IBOutlet weak var cellChoix1: UITableViewCell!
    @IBOutlet weak var labelChoix1: UILabel!
    
    @IBOutlet weak var cellChoix2: UITableViewCell!
    @IBOutlet weak var labelChoix2: UILabel!
    
    @IBOutlet weak var cellChoix3: UITableViewCell!
    @IBOutlet weak var labelChoix3: UILabel!
    
    @IBOutlet weak var cellBtnPrecSuiv: UITableViewCell!
    @IBOutlet weak var buttonQuestionPrecedente: UIButton!
    @IBAction func btnQuestionPrecedente(_ sender: Any) {
        // If this quiz has been saved
        if allQuizzAnswered.index(forKey: numeroQuestion!-1) != nil && numeroQuestion!-1 >= 1{
            buttonQuestionSuivante.isHidden = false
            //--
            showViewReponse = true
            numeroQuestion = numeroQuestion! - 1
            let quizSaved = allQuizzAnswered[numeroQuestion!]!
            numberRandom = quizSaved.getRandomValue
            self.loadQuizQuestion()
            //--
            buttonQuestionPrecedente.isHidden = numeroQuestion <= 1
        }
    }
    @IBOutlet weak var buttonQuestionSuivante: UIButton!
    @IBAction func btnQuestionSuivante(_ sender: Any) {
        buttonQuestionSuivante.isHidden = true
        showViewReponse = false
        // If quiz is not finished
        if(numeroQuestion+1 <= totalQuestion){
            numeroQuestion = numeroQuestion! + 1
            if allNumberRandom.index(forKey: numeroQuestion) != nil{
                numberRandom = allNumberRandom[numeroQuestion]!
                //--
                if allQuizzAnswered.index(forKey: numeroQuestion!) != nil{
                    showViewReponse = true
                    buttonQuestionSuivante.isHidden = false
                }
            }
            self.loadQuizQuestion()
        }
    }
    @IBOutlet weak var buttonValiderQuiz: UIButton!
    @IBAction func btnValiderQuiz(_ sender: Any) {
        isGoodAnswer = currentQuiz.getChoixCorrecte.lowercased()==choixSelected!
        // Save user choice
        if allQuizzAnswered.index(forKey: numeroQuestion!) == nil{
            var reponseDetail:String!
            if(currentQuiz.getChoixCorrecte.lowercased()=="choix1") { reponseDetail = currentQuiz.getChoix1 }
            if(currentQuiz.getChoixCorrecte.lowercased()=="choix2") { reponseDetail = currentQuiz.getChoix2 }
            if(currentQuiz.getChoixCorrecte.lowercased()=="choix3") { reponseDetail = currentQuiz.getChoix3 }
            let confirmReponse = isGoodAnswer ? "TRÈS BIEN RÉPONDU\nLa réponse est effectivement:" : "MAUVAISE RÉPONSE\nLa bonne réponse est:"
            let quiz = Quiz(question: currentQuiz.getQuestion, categorie: currentQuiz.getCategorie, choix1: currentQuiz.getChoix1, choix2: currentQuiz.getChoix2, choix3: currentQuiz.getChoix2, choixcorrecte: currentQuiz.getChoixCorrecte, explication: currentQuiz.getExplication, userChoix: choixSelected!, randomValue: numberRandom, confirmReponse: confirmReponse+" "+reponseDetail.uppercased())
            allQuizzAnswered.updateValue(quiz, forKey: numeroQuestion!)
            print("allQuizzAnswered HAS BEEN SAVED")
            print("Total after saved = \(allQuizzAnswered.count)")
        }
        
        // If good answer
        if(isGoodAnswer){
            showViewReponse = false
            totalBonneReponse = totalBonneReponse! + 1
            if(numeroQuestion! + 1 <= totalQuestion){
                numeroQuestion = numeroQuestion! + 1
            }
        }
        else{
            showViewReponse = true
            totalMauvaiseReponse = totalMauvaiseReponse! + 1
        }
        //--
        self.loadQuizQuestion()
    }
    
    
    // Ref attributes
    var quizMenuSelected:String?
    
    let segueIdentifier = "quizGameToExplication"
    
    private var allQuiz = [Quiz]()
    private var allQuizzAnswered: [Int : Quiz] = [:]
    private var currentQuiz:Quiz!
    private var choixSelected:String!
    private var labelHeight:CGFloat!
    
    private var showViewReponse = false
    private var isGoodAnswer = false
    private var numberRandom = 0
    private var allNumberRandom: [Int : Int] = [:]
    
    private var totalQuestion:Int!
    private var numeroQuestion:Int!
    private var totalBonneReponse:Int!
    private var totalMauvaiseReponse:Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadParameterData()
        
        if quizMenuSelected != nil{
            title = quizMenuSelected!
            //--
            loadJsonDataFromMenuSelected{ (allQuiz) in
                // Download completed.
                self.loadQuizQuestion()
            }
        }
        quizGameTableView.tableFooterView = UIView()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfCell = 1
        switch section {
        case 0: numberOfCell = 1
        case 1: numberOfCell = showViewReponse ? 1 : 0
        case 2: numberOfCell = 5
        default: break
        }
        return numberOfCell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPathSection = indexPath.section
        let indexPathRow = indexPath.row
        // If choice is done
        if(indexPathSection==2){
            print("Total before saved = \(allQuizzAnswered.count)")
            //--
            choixSelected = "choix\(indexPathRow)"
            print("choixSelected =====> "+choixSelected)
            //--
            if allQuizzAnswered.index(forKey: numeroQuestion!) == nil && indexPathRow > 0 && indexPathRow < 4{
                buttonValiderQuiz.isHidden = false
            }
            //--
            let selectedBorderColor = hexStringToUIColor(hex: "#F5876E")
            let unSelectedBorderColor = hexStringToUIColor(hex: "#7a7999")
            //--
            if allQuizzAnswered.index(forKey: numeroQuestion!) == nil{
                labelChoix1.layer.borderColor = unSelectedBorderColor.cgColor
                labelChoix2.layer.borderColor = unSelectedBorderColor.cgColor
                labelChoix3.layer.borderColor = unSelectedBorderColor.cgColor
            }
            //--
            if choixSelected! == "choix1"{
                labelChoix1.layer.borderColor = selectedBorderColor.cgColor
                labelChoix2.layer.borderColor = unSelectedBorderColor.cgColor
                labelChoix3.layer.borderColor = unSelectedBorderColor.cgColor
            }
            if choixSelected! == "choix2"{
                labelChoix1.layer.borderColor = unSelectedBorderColor.cgColor
                labelChoix2.layer.borderColor = selectedBorderColor.cgColor
                labelChoix3.layer.borderColor = unSelectedBorderColor.cgColor
            }
            if choixSelected! == "choix3"{
                labelChoix1.layer.borderColor = unSelectedBorderColor.cgColor
                labelChoix2.layer.borderColor = unSelectedBorderColor.cgColor
                labelChoix3.layer.borderColor = selectedBorderColor.cgColor
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier{
            if let newController = segue.destination as? ExplicationController{
                newController.explicationSelected = sender as? String
            }
        }
    }
    
    private func loadQuizQuestion(){
        numberRandom = showViewReponse ? numberRandom : randomValue(allQuiz.count)
        currentQuiz = allQuiz[numberRandom]
        //--
        buttonValiderQuiz.isHidden = true
        buttonQuestionPrecedente.isHidden = true
        if numeroQuestion > 1{
            buttonQuestionPrecedente.isHidden = false
        }
        buttonQuestionSuivante.isHidden = true
        if showViewReponse{
            buttonQuestionSuivante.isHidden = false
        }
        //--
        labelQuestion.text = currentQuiz.getQuestion
        //--
        let borderColor = hexStringToUIColor(hex: "#7a7999")
        let backgroundColor = hexStringToUIColor(hex: "#f5f5f7")
        //--
        labelChoix1.text = currentQuiz.getChoix1.uppercased()
        labelChoix1.cornerRadius
        labelChoix1.layer.borderColor = borderColor.cgColor
        labelChoix1.backgroundColor = backgroundColor
        //--
        labelChoix2.text = currentQuiz.getChoix2.uppercased()
        labelChoix2.cornerRadius
        labelChoix2.layer.borderColor = borderColor.cgColor
        labelChoix2.backgroundColor = backgroundColor
        //--
        labelChoix3.text = currentQuiz.getChoix3.uppercased()
        labelChoix3.cornerRadius
        labelChoix3.layer.borderColor = borderColor.cgColor
        labelChoix3.backgroundColor = backgroundColor
        //--
        loadScoreData()
        //--
        loadViewReponseData()
        //--
        if numeroQuestion <= totalQuestion {
            quizGameTableView.reloadData()
            // If game is ended
            if totalBonneReponse+totalMauvaiseReponse == totalQuestion{
                // Hide next button
                buttonQuestionSuivante.isHidden = true
                // Game is ended
                let alertController = UIAlertController(title: "FIN DE LA PARTIE", message: "Le jeu est terminé ! vous avez obtenu un score de \(totalBonneReponse!) sur \(totalQuestion!)", preferredStyle: .alert)
                let actionOK = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                    self.navigationController?.popViewController(animated: true)
                }
                alertController.addAction(actionOK)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    private func loadViewReponseData(){
        var goodOrBadAnswer = isGoodAnswer
        // Allow cells to be selected
        cellChoix1.isUserInteractionEnabled = true
        cellChoix2.isUserInteractionEnabled = true
        cellChoix3.isUserInteractionEnabled = true
        if(showViewReponse){
            if allQuizzAnswered.index(forKey: numeroQuestion!) != nil{
                let quizSaved = allQuizzAnswered[numeroQuestion!]!
                labelReponse.text = quizSaved.getConfirmReponse
                goodOrBadAnswer = quizSaved.getUserChoix.lowercased() == quizSaved.getChoixCorrecte.lowercased()
                // Don't allow cells to be selected
                cellChoix1.isUserInteractionEnabled = false
                cellChoix2.isUserInteractionEnabled = false
                cellChoix3.isUserInteractionEnabled = false
                // Show user choice
                let selectedBorderColor = hexStringToUIColor(hex: "#F5876E")
                if quizSaved.getUserChoix.lowercased() == "choix1"{ labelChoix1.layer.borderColor = selectedBorderColor.cgColor }
                if quizSaved.getUserChoix.lowercased() == "choix2"{ labelChoix2.layer.borderColor = selectedBorderColor.cgColor }
                if quizSaved.getUserChoix.lowercased() == "choix3"{ labelChoix3.layer.borderColor = selectedBorderColor.cgColor }
            }
            //--
            viewUserAnswer(success: goodOrBadAnswer)
        }
    }
    
    private func loadScoreData(){
        labelDate.text = currentStringDate()
        labelNumeroQuestion.text = "\(numeroQuestion!)/\(totalQuestion!)"
        labelNumeroQuestion.cornerRadius
        labelNote.text = "\(totalBonneReponse!)/\(totalQuestion!)"
        labelReponsesTrouvees.text = "\(totalBonneReponse!) TROUVE"+(totalBonneReponse! > 1 ? "S" : "")+" | \(totalMauvaiseReponse!) ERREUR"+(totalMauvaiseReponse! > 1 ? "S" : "")
        //--
        loadStarData()
    }
    
    private func loadStarData(){
        let totalRatio:Double! = 10.0/Double(totalQuestion!) * Double(totalBonneReponse!)
        if(totalRatio==0.5) { self.imageEtoile1.image = #imageLiteral(resourceName: "star_middle_fill_16") }
        if(totalRatio==1.0) { self.imageEtoile1.image = #imageLiteral(resourceName: "star_fill_16") }
        if(totalRatio==1.5) { self.imageEtoile2.image = #imageLiteral(resourceName: "star_middle_fill_16") }
        if(totalRatio==2.0) { self.imageEtoile2.image = #imageLiteral(resourceName: "star_fill_16") }
        if(totalRatio==2.5) { self.imageEtoile3.image = #imageLiteral(resourceName: "star_middle_fill_16") }
        if(totalRatio==3.0) { self.imageEtoile3.image = #imageLiteral(resourceName: "star_fill_16") }
        if(totalRatio==3.5) { self.imageEtoile4.image = #imageLiteral(resourceName: "star_middle_fill_16") }
        if(totalRatio==4.0) { self.imageEtoile4.image = #imageLiteral(resourceName: "star_fill_16") }
        if(totalRatio==4.5) { self.imageEtoile5.image = #imageLiteral(resourceName: "star_middle_fill_16") }
        if(totalRatio==5.0) { self.imageEtoile5.image = #imageLiteral(resourceName: "star_fill_16") }
        if(totalRatio==5.5) { self.imageEtoile6.image = #imageLiteral(resourceName: "star_middle_fill_16") }
        if(totalRatio==6.0) { self.imageEtoile6.image = #imageLiteral(resourceName: "star_fill_16") }
        if(totalRatio==6.5) { self.imageEtoile7.image = #imageLiteral(resourceName: "star_middle_fill_16") }
        if(totalRatio==7.0) { self.imageEtoile7.image = #imageLiteral(resourceName: "star_fill_16") }
        if(totalRatio==7.5) { self.imageEtoile8.image = #imageLiteral(resourceName: "star_middle_fill_16") }
        if(totalRatio==8.0) { self.imageEtoile8.image = #imageLiteral(resourceName: "star_fill_16") }
        if(totalRatio==8.5) { self.imageEtoile9.image = #imageLiteral(resourceName: "star_middle_fill_16") }
        if(totalRatio==9.0) { self.imageEtoile9.image = #imageLiteral(resourceName: "star_fill_16") }
        if(totalRatio==9.5) { self.imageEtoile10.image = #imageLiteral(resourceName: "star_middle_fill_16") }
        if(totalRatio==10.0) { self.imageEtoile10.image = #imageLiteral(resourceName: "star_fill_16") }
    }
    
    // Load Json from menu selected
    func loadJsonDataFromMenuSelected(completion: @escaping ([Quiz]) -> Void){
        allQuiz = [Quiz]()
        var mFileJsonPath:String?
        let menuQuizz:[String] = ["Toute la Bible", "Torah (Loi)", "Nevi'im (Prophètes)", "Ketouvim (Écrits)", "Évangiles", "Testament de Jésus"]
        let fileQuizz:[String] = ["toute_la_bible", "torah_loi", "neviim_prophete", "ketouvim_ecrits", "evangiles", "testament_de_jesus"]
        switch quizMenuSelected! {
        case menuQuizz[0]: mFileJsonPath = fileQuizz[0]
        case menuQuizz[1]: mFileJsonPath = fileQuizz[1]
        case menuQuizz[2]: mFileJsonPath = fileQuizz[2]
        case menuQuizz[3]: mFileJsonPath = fileQuizz[3]
        case menuQuizz[4]: mFileJsonPath = fileQuizz[4]
        case menuQuizz[5]: mFileJsonPath = fileQuizz[5]
            
        default: break
        }
        //--
        if let fileJsonPath = mFileJsonPath{
            DispatchQueue.main.async {
                do{
                    let filePath = Bundle.main.path(forResource: fileJsonPath, ofType: "json")
                    let fileUrl = URL(fileURLWithPath: filePath!)
                    let jsonData = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                    let json = try? JSONSerialization.jsonObject(with: jsonData)
                    //--
                    for jsonObject in json as! NSArray {
                        let question = (jsonObject as! NSObject).value(forKeyPath: "question") as! String
                        let categorie = (jsonObject as! NSObject).value(forKeyPath: "categorie") as! String
                        let choix1 = (jsonObject as! NSObject).value(forKeyPath: "choix1") as! String
                        let choix2 = (jsonObject as! NSObject).value(forKeyPath: "choix2") as! String
                        let choix3 = (jsonObject as! NSObject).value(forKeyPath: "choix3") as! String
                        let choixcorrecte = (jsonObject as! NSObject).value(forKeyPath: "choixcorrecte") as! String
                        let explication = (jsonObject as! NSObject).value(forKeyPath: "explication") as! String
                        //--
                        let quiz = Quiz(question:question, categorie:categorie, choix1:choix1, choix2:choix2, choix3:choix3, choixcorrecte:choixcorrecte, explication:explication)
                        //--
                        //print(question)
                        self.allQuiz.append(quiz)
                    }
                    completion(self.allQuiz)
                }
                catch {
                    print("Error ! Unable to read contents of the file url")
                }
            }
        }
    }
    
    // Random
    private func randomValue(_ n:Int) -> Int{
        var randomValue = Int(arc4random_uniform(UInt32(n)))
        if allNumberRandom.index(forKey: numeroQuestion!) == nil{
            allNumberRandom.updateValue(randomValue, forKey: numeroQuestion!)
        }
        else{
            randomValue = allNumberRandom[numeroQuestion!]!
        }
        return randomValue
    }
    
    // View visibility
    private func showViewSolutionQuestion(showView:Bool, view: UIView){
        let viewHeight:CGFloat = showView ? 128 : 0.0
        view.visiblity(gone: !showView, dimension: viewHeight)
    }
    
    // String to UIColor
    private func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in:
            .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    // View in terms of user answer (True ou False)
    private func viewUserAnswer(success: Bool){
        var borderColor:UIColor!
        var viewBackgroundColor:UIColor!
        var buttonBackgroundColor:UIColor!
        if(success){
            borderColor = self.hexStringToUIColor(hex: "#00ad0c")
            buttonBackgroundColor = self.hexStringToUIColor(hex: "#39ba43")
            viewBackgroundColor = self.hexStringToUIColor(hex: "#8bd690")
        }
        else{
            borderColor = self.hexStringToUIColor(hex: "#f5876e")
            buttonBackgroundColor = self.hexStringToUIColor(hex: "#f31f07")
            viewBackgroundColor = self.hexStringToUIColor(hex: "#ef4b3a")
        }
        cellRepExplication.contentView.backgroundColor = viewBackgroundColor
        buttonExplication.backgroundColor = buttonBackgroundColor
        buttonExplication.layer.borderColor = borderColor.cgColor
        buttonExplication.layer.cornerRadius = 20.0
        buttonExplication.layer.masksToBounds = true
        buttonExplication.layer.borderWidth = 2.0
    }
    
    // Current Sting date
    private func currentStringDate()->String{
        let dateCurrent = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year], from: dateCurrent)
        let day = Int(components.day!) >= 10 ? "\(components.day!)" : "0\(components.day!)"
        let month = Int(components.month!) >= 10 ? "\(components.month!)" : "0\(components.month!)"
        return "\(day)/\(month)/\(components.year!)"
    }
    
    // Load parameters data
    private func loadParameterData(){
        cellQuestion.isUserInteractionEnabled = false
        cellScore.isUserInteractionEnabled = false
        //--
        totalQuestion = 10
        numeroQuestion = 1
        totalBonneReponse = 0
        totalMauvaiseReponse = 0
        // borderColor
        var borderColor = hexStringToUIColor(hex: "#12114A")
        cellScore.contentView.layer.borderWidth = 2.0
        cellScore.contentView.layer.borderColor = borderColor.cgColor
        cellScore.contentView.frame = UIEdgeInsetsInsetRect(cellScore.contentView.frame, UIEdgeInsetsMake(5, 5, 5, 5))
        borderColor = hexStringToUIColor(hex: "#F5876E")
        labelNumeroQuestion.layer.borderWidth = 2.0
        labelNumeroQuestion.layer.borderColor = borderColor.cgColor
    }
}

extension UIView {
    func visiblity(gone: Bool, dimension: CGFloat = 0.0, attribute: NSLayoutAttribute = .height) -> Void {
        if let constraint = (self.constraints.filter{$0.firstAttribute == attribute}.first) {
            constraint.constant = gone ? 0.0 : dimension
            self.layoutIfNeeded()
            self.isHidden = gone
        }
    }
}
