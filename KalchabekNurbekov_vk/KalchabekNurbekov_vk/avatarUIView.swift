//
//  avatarUIView.swift
//  KalchabekNurbekov_vk
//
//  Created by Kalchabek Nurbekov on 28.04.2022.
//

import UIKit

class avatarUIView: UIView {
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var shadowView: UIView!
    var shadowColor = UIColor.blue
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shadowView.layer.shadowColor = shadowColor.cgColor
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowRadius = 7
        shadowView.layer.shadowOpacity = 0.8
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        shadowView.layer.cornerRadius = bounds.height/2
        avatarImageView.layer.cornerRadius = bounds.height/2
        
    }
}
