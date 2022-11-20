//
//  FriendXibTableViewCell.swift
//  KalchabekNurbekov_vk
//
//  Created by Kalchabek Nurbekov on 17.05.2022.
//

import UIKit

class FriendXibTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        friendImageView.layer.cornerRadius = friendImageView.bounds.width/2

    }

    @IBOutlet var friendImageView: UIImageView!
    @IBOutlet var friendNameLabel: UILabel!
    @IBOutlet var friendAgeLabel: UILabel!

}
