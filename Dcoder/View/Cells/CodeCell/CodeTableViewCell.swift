//
//  CodeTableViewCell.swift
//  Dcoder
//
//  Created by Arun Jose on 24/03/19.
//  Copyright © 2019 Arun Jose. All rights reserved.
//

import UIKit
import TagListView
import PINRemoteImage

class CodeTableViewCell: UITableViewCell {
    @IBOutlet weak var tagView: TagListView!
    @IBOutlet weak var codeTitle: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var downVoteLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var upVoteLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(forCode code:Code) {
        
        tagView.removeAllTags()
        tagView.addTags(code.tags ?? [])
        self.commentLabel.text = String(code.comments ?? 0)
        self.upVoteLabel.text = String(code.upvotes ?? 0)
        self.downVoteLabel.text = String(code.downvotes ?? 0)
        if let profileUrl = code.userImageURL {
            self.profileImageView.layer.masksToBounds = true
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width/2
            self.profileImageView.pin_setImage(from: URL(string: profileUrl))
        }
        self.userName.text = code.userName
        self.codeTitle.text = code.title
        if let date = code.time {
            self.timeLabel.text = getDaysAgoFrom(date: date)
        }
        
    }
    
    fileprivate func getDaysAgoFrom(date:String) -> String {
        
        let timeInterval = Double(date)
        let postedDate = Date(timeIntervalSince1970: timeInterval ?? 0)
        print(postedDate)
        
        let calendar = Calendar.current
        let date1 = calendar.startOfDay(for: postedDate)
        let date2 = calendar.startOfDay(for: Date())

        let components = calendar.dateComponents([.day], from: date1, to: date2)
        var daysAgo = ""
        if components.day != 0{
            if let days = components.day, days < 7 {
                daysAgo = "\(components.day ?? 0) days ago"
            }else{
                daysAgo = "7+ days ago"
            }
        } else if components.hour != 0 {
            daysAgo = "\(components.hour ?? 0) hrs ago"
        } else if components.minute != 0 {
            daysAgo = "\(components.minute ?? 0) mins ago"
        } else if components.second != 0 {
            daysAgo = "\(components.second ?? 0) secs ago"
        }
        return daysAgo
    }
    
}
