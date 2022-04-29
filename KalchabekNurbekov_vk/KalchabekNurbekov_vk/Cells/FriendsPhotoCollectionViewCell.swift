//
//  FriendsPhotoCollectionViewCell.swift
//  KalchabekNurbekov_vk
//
//  Created by Kalchabek Nurbekov on 19.04.2022.
//
import Foundation
import UIKit

class FriendsPhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var friendPhoto: UIImageView!
    
    @IBOutlet var likeControl: LikeControl!
    @IBOutlet var containerView: UIView!
    
    override func awakeFromNib() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.numberOfTapsRequired = 2
        containerView.addGestureRecognizer(tap)
        
    }
    
    @objc func handleTap(_ : UIGestureRecognizer) {
        likeControl.isLike.toggle()
        
        if likeControl.isLike {
            likeControl.likePicture.image = UIImage(named: "suit.heart.fill")
        } else {
            likeControl.likePicture.image = nil
        }
    
    }
}
