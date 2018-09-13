//
//  QuizGameCell.swift
//  QuestionsReponses
//
//  Created by Eric Digbeu on 12/09/2018.
//  Copyright © 2018 ANJC Productions. All rights reserved.
//

import UIKit

class QuizAppCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(3, 3, 3, 3))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
