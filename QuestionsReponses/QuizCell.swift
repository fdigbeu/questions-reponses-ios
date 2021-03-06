//
//  QuizCell.swift
//  QuestionsReponses
//
//  Created by Eric Digbeu on 25/08/2018.
//  Copyright © 2018 ANJC Productions. All rights reserved.
//

import UIKit

class QuizCell: UITableViewCell {
    @IBOutlet weak var imageQuiz: UIImageView!
    @IBOutlet weak var labelQuiz: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(5, 5, 5, 5))
    }
    
    func loadDataCell(itemValue:String) -> QuizCell {
        self.labelQuiz.text = itemValue
        self.imageQuiz.image = #imageLiteral(resourceName: "bible_64")
        // borderColor
        let borderColor = hexStringToUIColor(hex: "#12114A")
        self.contentView.layer.borderWidth = 2.0
        self.contentView.layer.borderColor = borderColor.cgColor
        self.contentView.layer.cornerRadius = 30.0
        self.contentView.layer.masksToBounds = true
        return self
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
}
