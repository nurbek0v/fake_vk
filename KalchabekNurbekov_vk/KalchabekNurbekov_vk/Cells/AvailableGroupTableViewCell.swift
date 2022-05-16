//
//  AvailableGroupTableViewCell.swift
//  KalchabekNurbekov_vk
//
//  Created by Kalchabek Nurbekov on 19.04.2022.
//

import UIKit

class AvailableGroupTableViewCell: UITableViewCell {
    @IBOutlet weak var availableGroupImage: UIImageView!
    @IBOutlet weak var availableGroupName: UILabel!
    @IBOutlet weak var availableGroupCity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func set(group: Group) {
        self.availableGroupName.text = group.name
        self.availableGroupCity.text = group.city
        self.availableGroupImage.image = group.image
    }

}
