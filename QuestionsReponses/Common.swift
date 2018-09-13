//
//  Common.swift
//  QuestionsReponses
//
//  Created by Eric Digbeu on 25/08/2018.
//  Copyright © 2018 ANJC Productions. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class Common {
    var activityIndicator:UIActivityIndicatorView!
    var playerController:AVPlayerViewController!
    var player:AVPlayer!
    
    init() {
        self.activityIndicator = UIActivityIndicatorView()
    }
    
    func showActivityIndicatorView(view: AnyObject) -> Void {
        DispatchQueue.main.async {
            self.activityIndicator.center = view.center
            self.activityIndicator.hidesWhenStopped = true
            self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            view.addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideActivityIndicatorView() -> Void {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
}
