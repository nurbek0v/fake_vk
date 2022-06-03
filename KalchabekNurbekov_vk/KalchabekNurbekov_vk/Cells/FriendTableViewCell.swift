//
//  FriendTableViewCell.swift
//  KalchabekNurbekov_vk
//
//  Created by Kalchabek Nurbekov on 18.04.2022.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBOutlet weak var friendsName: UILabel!
    @IBOutlet weak var friendsAge: UILabel!
    @IBOutlet weak var friendsPhoto: UIImageView!
  
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        friendsPhoto.layer.cornerRadius = friendsPhoto.bounds.width/2
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func set(friend: Friend) {
        self.friendsName.text = friend.name
        self.friendsAge.text = friend.age
        self.friendsPhoto.image = friend.avatar
    }

}
