//
//  NewsTableViewCell.swift
//  KalchabekNurbekov_vk
//
//  Created by Kalchabek Nurbekov on 31.05.2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var postAvatar: UIImageView!
    @IBOutlet weak var postName: UILabel!
    
    @IBOutlet weak var postDate: UILabel!
    
    @IBOutlet weak var postText: UILabel!
    
    @IBOutlet weak var postImage: UIImageView!
    
    
    
    
    
}
