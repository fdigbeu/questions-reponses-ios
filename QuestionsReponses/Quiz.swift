//
//  Quiz.swift
//  QuestionsReponses
//
//  Created by Eric Digbeu on 03/09/2018.
//  Copyright © 2018 ANJC Productions. All rights reserved.
//

import Foundation

class Quiz{
    private var question:String!
    private var categorie:String!
    private var choix1:String!
    private var choix2:String!
    private var choix3:String!
    private var choixcorrecte:String! // choix1, choix2 ou choix3
    private var explication:String!
    private var userChoix:String! // choix1, choix2 ou choix3
    private var randomValue:Int!
    private var confirmReponse:String!
    
    init(question:String, categorie:String, choix1:String, choix2:String, choix3:String, choixcorrecte:String, explication:String) {
        self.question = question
        self.categorie = categorie
        self.choix1 = choix1
        self.choix2 = choix2
        self.choix3 = choix3
        self.choixcorrecte = choixcorrecte
        self.explication = explication
    }
    
    init(question:String, categorie:String, choix1:String, choix2:String, choix3:String, choixcorrecte:String, explication:String, userChoix:String, randomValue:Int, confirmReponse:String) {
        self.question = question
        self.categorie = categorie
        self.choix1 = choix1
        self.choix2 = choix2
        self.choix3 = choix3
        self.choixcorrecte = choixcorrecte
        self.explication = explication
        self.userChoix = userChoix
        self.randomValue = randomValue
        self.confirmReponse = confirmReponse
    }
    
    var getQuestion:String { return question }
    var getCategorie:String { return categorie }
    var getChoix1:String { return choix1 }
    var getChoix2:String { return choix2 }
    var getChoix3:String { return choix3 }
    var getChoixCorrecte:String { return choixcorrecte }
    var getExplication:String { return explication }
    var getUserChoix:String { return userChoix }
    var getRandomValue:Int { return randomValue }
    var getConfirmReponse:String { return confirmReponse }
}
