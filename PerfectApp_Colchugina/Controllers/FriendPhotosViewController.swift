//
//  FriendPhotosController.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 02.05.2021.
//

import UIKit

class FriendPhotosViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var mainPhotoImageView: UIImageView!
    @IBOutlet var nameLable: UILabel!
    @IBOutlet var photosCollectoinView: UICollectionView!
    var selectedFriend: Friends!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.photosCollectoinView.delegate = self
        self.photosCollectoinView.dataSource = self
        nameLable.text = selectedFriend.name
        mainPhotoImageView.image = UIImage(named: selectedFriend.photo[0])
        mainPhotoImageView.contentMode = .scaleAspectFill
        mainPhotoImageView.clipsToBounds = true
        mainPhotoImageView.layer.cornerRadius = mainPhotoImageView.frame.height/2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedFriend.photo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.reuseId, for: indexPath) as! PhotosCollectionViewCell
        cell.photoImageView.image = UIImage(named: selectedFriend.photo[indexPath.row])
        cell.photoImageView.contentMode = .scaleAspectFill
        cell.photoImageView.clipsToBounds = true
        
        return cell

    }
    
    
    
    

}
