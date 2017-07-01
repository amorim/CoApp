//
//  UsuarioTableViewCell.swift
//  CoApp
//
//  Created by Student on 3/9/17.
//  Copyright © 2017 Lucas Amorim. All rights reserved.
//

import UIKit

class UsuarioTableViewCell: UITableViewCell {

    @IBOutlet var lblNome: UILabel!
    @IBOutlet var lblEmail: UILabel!
    @IBOutlet var imgUser: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
