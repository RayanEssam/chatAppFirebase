//
//  UserTableViewCell.swift
//  ChatApp
//
//  Created by Rayan Taj on 07/12/2021.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet var userID: UILabel!
    @IBOutlet var message: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
