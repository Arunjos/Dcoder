//
//  MyChatTableViewCell.swift
//  Dcoder
//
//  Created by Arun Jose on 23/03/19.
//  Copyright © 2019 Arun Jose. All rights reserved.
//

import UIKit
import PINRemoteImage

class MyChatTableViewCell: UITableViewCell {

    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var messageContentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutIfNeeded()
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.bounds.size.width/2
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(forChat chat:Chat) {
        profileNameLabel.text = chat.userName
        messageContentLabel.text = chat.text
        
        messageView.layer.borderWidth = 1
        messageView.layer.cornerRadius = 5
        if let image = chat.userImage {
            profileImageView.pin_setImage(from: URL(string: image))
        }
        
    }
    
}
