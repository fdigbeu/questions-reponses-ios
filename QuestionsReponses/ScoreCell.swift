//
//  ScoreCell.swift
//  QuestionsReponses
//
//  Created by Eric Digbeu on 22/09/2018.
//  Copyright © 2018 ANJC Productions. All rights reserved.
//

import UIKit

class ScoreCell: UITableViewCell {
    
    @IBOutlet weak var labelTitre: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var imageIcone: UIImageView!
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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(5, 5, 5, 5))
    }
    
    func loadDataCell(imageValue:UIImage, titleValue:String, dateValue:String, totalTrouve:Int, totalQuestion:Int) -> ScoreCell {
        self.imageIcone.image = imageValue
        self.labelTitre.text = titleValue
        self.labelDate.text = dateValue
        self.loadStarData(totalTrouve:totalTrouve, totalQuestion:totalQuestion)
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
    
    private func loadStarData(totalTrouve:Int, totalQuestion:Int){
        let totalRatio:Double! = 10.0/Double(totalQuestion) * Double(totalTrouve)
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

}
