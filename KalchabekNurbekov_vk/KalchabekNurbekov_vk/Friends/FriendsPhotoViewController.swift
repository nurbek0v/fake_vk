//
//  CollectionViewController.swift
//  KalchabekNurbekov_vk
//
//  Created by Kalchabek Nurbekov on 13.04.2022.
//

import UIKit

class FriendsPhotoViewController: UICollectionViewController {
    
   public var photoArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        


    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendsPhotoCell", for: indexPath) as? FriendsPhotoCollectionViewCell else {fatalError("can not cast")}
        cell.friendPhoto.image = photoArray[indexPath.item]

    
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowBigPhoto",
           let selectPhoto = collectionView.indexPathsForSelectedItems?.first,
           let bigPhoto = segue.destination as? FriendsBigPhotoViewController {
            bigPhoto.bigPhotos = photoArray
            bigPhoto.selectedPhotoIndex = selectPhoto.item
        }
    }
}

extension FriendsPhotoViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 2
        let paddingWidth = 20 * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
        
    }
}
