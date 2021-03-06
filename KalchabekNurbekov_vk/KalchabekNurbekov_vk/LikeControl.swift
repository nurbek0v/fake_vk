//
//  LikeControl.swift
//  KalchabekNurbekov_vk
//
//  Created by Kalchabek Nurbekov on 28.04.2022.
//

import UIKit

class LikeControl: UIControl {

    @IBOutlet public var likePicture: UIImageView!
    
    var isLike: Bool = false
    
    override func awakeFromNib() {
      
        likePicture.tintColor = .blue
        likePicture.layer.cornerRadius = likePicture.bounds.height / 2
        likePicture.image = UIImage(systemName: "suit.heart")
      
        
    }

}
