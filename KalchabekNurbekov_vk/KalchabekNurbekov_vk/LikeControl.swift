//
//  LikeControl.swift
//  KalchabekNurbekov_vk
//
//  Created by Kalchabek Nurbekov on 28.04.2022.
//

import UIKit

class LikeControl: UIControl {

    @IBOutlet var likePicture: UIImageView!
    
    var isLike: Bool = false
    
    override func awakeFromNib() {
        likePicture.backgroundColor = .clear
        likePicture.tintColor = .red
        
    }

}
