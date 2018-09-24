//
//  ExplicationCell.swift
//  QuestionsReponses
//
//  Created by Eric Digbeu on 24/09/2018.
//  Copyright © 2018 ANJC Productions. All rights reserved.
//

import UIKit

class ExplicationCell: UITableViewCell {
    
    @IBOutlet weak var labelExplication: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func loadDataCell(titleValue:String) -> ExplicationCell {
        self.labelExplication.text = formatExplicationData(explication: titleValue)
        return self
    }
    
    private func formatExplicationData(explication:String) -> String{
        var stringToReturn:String = ""
        let explicationArray = explication.components(separatedBy: "\n")
        for line in explicationArray{
            let lineValue = line.trimmingCharacters(in: .whitespacesAndNewlines)
            // If title of chapter
            if lineValue.hasSuffix(":") && lineValue.count <= 25{
                stringToReturn += lineValue.uppercased()+"\n"
            }
            else{
                stringToReturn += lineValue+"\n"
            }
        }
        return stringToReturn
    }
}
