//
//  GallaryCollectionViewCell.swift
//  KalchabekNurbekov_vk
//
//  Created by Kalchabek Nurbekov on 14.11.2022.
//

import Foundation
import UIKit

class GallaryCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "GallaryCollectionViewCell"
    
    let myImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.gray
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(myImageView)
      
        
        //myImageView constraints
        myImageView.fillSuperview()
    }
    override func prepareForReuse() {
        myImageView.image = nil
        
    }
    func set(imageURL: String?) {
        myImageView.set(imageURL: imageURL)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myImageView.layer.masksToBounds = true
        myImageView.layer.cornerRadius = 10
        self.layer.shadowRadius = 3
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 2.5, height: 4)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
