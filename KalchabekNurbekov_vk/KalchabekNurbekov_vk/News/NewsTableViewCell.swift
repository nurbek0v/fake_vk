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
        postAvatar.layer.cornerRadius = postAvatar.bounds.width/2
        likeButton.layer.cornerRadius = likeButton.bounds.height/2
        commentButton.layer.cornerRadius = commentButton.bounds.height/2
        shareButton.layer.cornerRadius = shareButton.bounds.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var postAvatar: UIImageView!
    @IBOutlet weak var postName: UILabel!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var likeButton: UIImageView!
    @IBOutlet weak var commentButton: UIImageView!
    @IBOutlet weak var shareButton: UIImageView!
    @IBOutlet weak var viewButton: UIImageView!
    @IBOutlet weak var viewers: UILabel!
    
    
    
    
}
