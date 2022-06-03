//
//  FriendsBigPhotoViewController.swift
//  KalchabekNurbekov_vk
//
//  Created by Kalchabek Nurbekov on 03.06.2022.
//

import UIKit

class FriendsBigPhotoViewController: UIViewController {
    
    @IBOutlet var bigPhotoImage: UIImageView! {
        didSet {
            bigPhotoImage.isUserInteractionEnabled = true
        }
    }
    private var additionalImageView = UIImageView()
    
    public var bigPhotos: [UIImage] = []
    public var selectedPhotoIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard !bigPhotos.isEmpty else {return}
        bigPhotoImage.image = bigPhotos[selectedPhotoIndex]
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipeFunc))
        leftSwipe.direction = .left
        bigPhotoImage.addGestureRecognizer(leftSwipe)
        
        let RigthSwipe = UISwipeGestureRecognizer(target: self, action: #selector(RigthSwipeFunc))
        RigthSwipe.direction = .right
        bigPhotoImage.addGestureRecognizer(RigthSwipe)
        
        // Do any additional setup after loading the view.
        view.addSubview(additionalImageView)
        view.sendSubviewToBack(additionalImageView)
        additionalImageView.translatesAutoresizingMaskIntoConstraints = false
        additionalImageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            additionalImageView.leadingAnchor.constraint(equalTo: bigPhotoImage.leadingAnchor),
            additionalImageView.trailingAnchor.constraint(equalTo: bigPhotoImage.trailingAnchor),
            additionalImageView.topAnchor.constraint(equalTo: bigPhotoImage.topAnchor),
            additionalImageView.bottomAnchor.constraint(equalTo: bigPhotoImage.bottomAnchor)
            
        ])
    }
    @objc func leftSwipeFunc() {
        guard self.selectedPhotoIndex + 1 < self.bigPhotos.count   else {return}
        
        additionalImageView.transform = CGAffineTransform(translationX: additionalImageView.bounds.width, y: 10).concatenating(CGAffineTransform(scaleX: 1.2, y: 1.2))
        additionalImageView.image = bigPhotos[selectedPhotoIndex + 1]
        
        //animation
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: {
            self.bigPhotoImage.transform = CGAffineTransform(translationX: -self.bigPhotoImage.bounds.width - 200, y: -10).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
            self.additionalImageView.transform = .identity
        },
                       completion: {_ in
            
            self.selectedPhotoIndex += 1
            self.bigPhotoImage.image = self.bigPhotos[self.selectedPhotoIndex]
            self.bigPhotoImage.transform = .identity
            self.additionalImageView.image = nil
        })
    }
    
    
    
    @objc func RigthSwipeFunc() {
        guard selectedPhotoIndex  >= 1  else {return}
        
        
        additionalImageView.transform = CGAffineTransform(translationX: -additionalImageView.bounds.width * 1.5, y: -10).concatenating(CGAffineTransform(scaleX: 1.2, y: 1.2))
        additionalImageView.image = bigPhotos[selectedPhotoIndex - 1]
        
        //animation
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: {
            
            self.bigPhotoImage.transform = CGAffineTransform(translationX: self.bigPhotoImage.bounds.width * 1.5, y: -10).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
            self.additionalImageView.transform = .identity
        },
                       completion: {_ in
            
            self.selectedPhotoIndex -= 1
            self.bigPhotoImage.image = self.bigPhotos[self.selectedPhotoIndex]
            self.bigPhotoImage.transform = .identity
            self.additionalImageView.image = nil
            
        })
        
        
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
