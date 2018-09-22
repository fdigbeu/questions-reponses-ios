//
//  DAOQuiz.swift
//  QuestionsReponses
//
//  Created by Eric Digbeu on 22/09/2018.
//  Copyright © 2018 ANJC Productions. All rights reserved.
//

import Foundation
import UIKit
import SQLite3

class DAOQuiz{
    var db: OpaquePointer?
    final var tableScore = "qr_score"
    final var tableGame = "qr_game"
    
    init() {
        // Open connection
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("QuestionsReponses.sqlite")
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Error opening database")
            return
        }
        // Create score table
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS "+tableScore+" (id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, totalQuestion INTEGER, totalTrouve INTEGER, totalErreur INTEGER, keyGame TEXT)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Error creating qr_score table: \(errmsg)")
            return
        }
        // Create game table
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS "+tableGame+" (id INTEGER PRIMARY KEY AUTOINCREMENT, keyGame TEXT, question TEXT, categorie TEXT, choix1 TEXT, choix2 TEXT, choix3 TEXT, choixCorrecte TEXT, explication TEXT, userChoix TEXT, randomValue TEXT, confirmeReponse TEXT)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Error creating qr_score table: \(errmsg)")
            return
        }
        // All is fine
        print("=================================== init(Success) : All is fine ! ===================================")
    }
    
    // Score
    func getAllScoresInProgress() -> [Quiz] {
        var stmt: OpaquePointer?
        //This is our select query
        let queryString = "SELECT * FROM "+tableScore+" ORDER BY id DESC"
        //Preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Error preparing retrieve: \(errmsg)")
        }
        //Traversing through all the records
        var allQuizz = [Quiz]()
        while(sqlite3_step(stmt) == SQLITE_ROW){
            //let id = sqlite3_column_int(stmt, 0)
            let date = String(cString: sqlite3_column_text(stmt, 1))
            let totalQuestion = Int(sqlite3_column_int(stmt, 2))
            let totalTrouve = Int(sqlite3_column_int(stmt, 3))
            let totalErreur = Int(sqlite3_column_int(stmt, 4))
            let keyGame = String(cString: sqlite3_column_text(stmt, 5))
            if totalTrouve+totalErreur < totalQuestion{
                let quiz = Quiz(date: date, totalQuestion: totalQuestion, totalTrouve: totalTrouve, totalErreur: totalErreur, keyGame: keyGame)
                allQuizz.append(quiz)
            }
        }
        return allQuizz
    }
    
    func getAllScoresFinished() -> [Quiz] {
        var stmt: OpaquePointer?
        //This is our select query
        let queryString = "SELECT * FROM "+tableScore+" ORDER BY id DESC"
        //Preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("================ Error preparing retrieve: \(errmsg) ================")
        }
        //Traversing through all the records
        var allQuizz = [Quiz]()
        while(sqlite3_step(stmt) == SQLITE_ROW){
            //let id = sqlite3_column_int(stmt, 0)
            let date = String(cString: sqlite3_column_text(stmt, 1))
            let totalQuestion = Int(sqlite3_column_int(stmt, 2))
            let totalTrouve = Int(sqlite3_column_int(stmt, 3))
            let totalErreur = Int(sqlite3_column_int(stmt, 4))
            let keyGame = String(cString: sqlite3_column_text(stmt, 5))
            if totalTrouve+totalErreur == totalQuestion{
                let quiz = Quiz(date: date, totalQuestion: totalQuestion, totalTrouve: totalTrouve, totalErreur: totalErreur, keyGame: keyGame)
                allQuizz.append(quiz)
            }
        }
        return allQuizz
    }
    
    func addScore(date:String!, totalQuestion:Int!, totalTrouve:Int!, totalErreur:Int!, keyGame:String!) -> Void {
         var stmt: OpaquePointer?
        //The insert query
        let queryString = "INSERT INTO \(tableScore) (date, totalQuestion, totalTrouve, totalErreur, keyGame) VALUES ('\(date!)', '\(totalQuestion!)', '\(totalTrouve!)', '\(totalErreur!)', '\(keyGame!)')"
        //Preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("================ Error preparing insert: \(errmsg) ================")
        }
        //Executing the query to insert values
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("================ Failure inserting user: \(errmsg) ================")
        }
        //Displaying a success message
        print("================ Score saved successfully ! ================")
        print(queryString)
    }
    
    func modifyScore(totalTrouve:Int!, totalErreur:Int!, keyGame:String!) -> Void {
        var stmt: OpaquePointer?
        //The update query
        let queryString = "UPDATE \(tableScore) SET totalTrouve = '\(totalTrouve!)', totalErreur = '\(totalErreur!)' WHERE keyGame LIKE '\(keyGame!)'"
        //Preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("================ Error preparing update: \(errmsg) ================")
        }
        //Executing the query to update
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("================ Failure update score: \(errmsg) ================")
        }
        //Displaying a success message
        print("================ Score updated successfully ! ================")
        print(queryString)
    }
    
    func deleteAllScore() -> Void{
        var stmt: OpaquePointer?
        //The delete query
        let queryString = "DELETE FROM "+tableScore
        //Preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("================ Error preparing delete: \(errmsg) ================")
        }
        //Executing the query to delete
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("================ Failure deleting score: \(errmsg) ================")
        }
        //Displaying a success message
        print("================ Score delete successfully ! ================")
    }
    
    func addGame(keyGame:String!, question:String!, categorie:String!, choix1:String!, choix2:String!, choix3:String!, choixCorrecte:String!, explication:String!, userChoix:String!, randomValue:String!, confirmeReponse:String!) -> Void {
        var stmt: OpaquePointer?
        //The insert query
        let queryString = "INSERT INTO \(tableGame) (keyGame, question, categorie, choix1, choix2, choix3, choixCorrecte, explication, userChoix, randomValue, confirmeReponse) VALUES ('\(keyGame!)', '\(question!.replacingOccurrences(of: "'", with: "''"))', '\(categorie!.replacingOccurrences(of: "'", with: "''"))', '\(choix1!.replacingOccurrences(of: "'", with: "''"))', '\(choix2!.replacingOccurrences(of: "'", with: "''"))', '\(choix3!.replacingOccurrences(of: "'", with: "''"))', '\(choixCorrecte!)', '\(explication!.replacingOccurrences(of: "'", with: "''"))', '\(userChoix!.replacingOccurrences(of: "'", with: "''"))', '\(randomValue!)', '\(confirmeReponse!.replacingOccurrences(of: "'", with: "''"))')"
        //Preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("================ Error preparing insert: \(errmsg) ================")
        }
        //Executing the query to insert values
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("================ Failure inserting game: \(errmsg) ================")
        }
        //Displaying a success message
        print("================ Game saved successfully ! ================")
        print(queryString)
    }
    
    func getAllGames(keyGame:String!) -> [Quiz] {
        var stmt: OpaquePointer?
        //This is our select query
        let queryString = "SELECT * FROM "+tableGame+" WHERE keyGame LIKE '\(keyGame!)'"
        //Preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("================ Error preparing retrieve: \(errmsg) ================")
        }
        //Traversing through all the records
        var allQuizz = [Quiz]()
        while(sqlite3_step(stmt) == SQLITE_ROW){
            //let id = sqlite3_column_int(stmt, 0)
            let keyGame = String(cString: sqlite3_column_text(stmt, 1))
            let question = String(cString: sqlite3_column_text(stmt, 2))
            let categorie = String(cString: sqlite3_column_text(stmt, 3))
            let choix1 = String(cString: sqlite3_column_text(stmt, 4))
            let choix2 = String(cString: sqlite3_column_text(stmt, 5))
            let choix3 = String(cString: sqlite3_column_text(stmt, 6))
            let choixCorrecte = String(cString: sqlite3_column_text(stmt, 7))
            let explication = String(cString: sqlite3_column_text(stmt, 8))
            let userChoix = String(cString: sqlite3_column_text(stmt, 9))
            let randomValue = String(cString: sqlite3_column_text(stmt, 10))
            let confirmeReponse = String(cString: sqlite3_column_text(stmt, 11))
            let quiz = Quiz(question: question, categorie: categorie, choix1: choix1, choix2: choix2, choix3: choix3, choixcorrecte: choixCorrecte, explication: explication, userChoix: userChoix, randomValue: Int(randomValue)!, confirmReponse: confirmeReponse, keyGame: keyGame)
            allQuizz.append(quiz)
        }
        return allQuizz
    }
}
