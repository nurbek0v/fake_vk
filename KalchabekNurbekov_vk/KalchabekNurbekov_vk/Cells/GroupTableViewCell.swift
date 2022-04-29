//
//  GroupTableViewCell.swift
//  KalchabekNurbekov_vk
//
//  Created by Kalchabek Nurbekov on 19.04.2022.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupCity: UILabel!
    @IBOutlet weak var groupImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func set(group: Group) {
        self.groupName.text = group.name
        self.groupCity.text = group.city
        self.groupImage.image = group.image
    }
    
}
