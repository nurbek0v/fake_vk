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
            UIView.animateKeyframes(withDuration: 0.1, delay: 0, options: .calculationModeCubic, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 1, animations: {
                    self.likeControl.likePicture.image = UIImage(systemName: "suit.heart.fill")
                })
                UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 1, animations: {
                    self.likeControl.likePicture.tintColor = .red
                })
            }, completion: nil)
            
        } else {
            UIView.animateKeyframes(withDuration: 0.1, delay: 0, options: .calculationModeCubic, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 1, animations: {
                    self.likeControl.likePicture.image = UIImage(systemName: "suit.heart")
                })
                UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 1, animations: {
                    self.likeControl.likePicture.tintColor = .blue
                })
            }, completion: nil)
           // likeControl.likePicture.image = UIImage(systemName: "suit.heart")
        }
    
    }
}
