//
//  PhotosCollectionViewCell.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 02.05.2021.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var likeCintrol: LikeControl!
    static let reuseId = "PhotosCollectionViewCell"
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func config (_ photo: String) {
        self.photoImageView.image = UIImage(named: photo)
        self.photoImageView.contentMode = .scaleAspectFill
        self.photoImageView.clipsToBounds = true
    }
    
   
}
