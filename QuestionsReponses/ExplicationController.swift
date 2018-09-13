//
//  ExplicationController.swift
//  QuestionsReponses
//
//  Created by Eric Digbeu on 06/09/2018.
//  Copyright © 2018 ANJC Productions. All rights reserved.
//

import UIKit
import WebKit

class ExplicationController: UIViewController, WKUIDelegate {
    
    @IBOutlet weak var explicationTextView: UITextView!
    
    var explicationSelected:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //--
        title = "Explication"
        if let explication = explicationSelected{
            print(explication)
            explicationTextView.text = explication
        }
    }
}
