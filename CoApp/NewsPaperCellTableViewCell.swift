//
//  NewsPaperCellTableViewCell.swift
//  CoApp
//
//  Created by Student on 3/9/17.
//  Copyright © 2017 Lucas Amorim. All rights reserved.
//

import UIKit

class NewsPaperCellTableViewCell: UITableViewCell {

    @IBOutlet var lblNome: UILabel!
    
    @IBOutlet var lblCriador: UILabel!
    
    
    @IBOutlet var lblUrl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
