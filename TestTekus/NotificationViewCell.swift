//
//  NotificationViewCell.swift
//  TestTekus
//
//  Created by Oswaldo Garcia on 1/27/17.
//  Copyright © 2017 Oswaldo Garcia. All rights reserved.
//

import UIKit

class NotificationViewCell: UITableViewCell {
    
    @IBOutlet weak var lbNotificationId: UILabel!
    
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbDuration: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(data:Dictionary<String, Any>){
        
        self.lbNotificationId.text = String(describing: data["NotificationId"]!) as String
        self.lbDate.text = data["Date"] as! String?
        self.lbDuration.text = String(describing: data["Duration"]!)+"s" as String
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
