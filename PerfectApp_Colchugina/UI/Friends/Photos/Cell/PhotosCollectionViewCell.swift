//
//  PhotosCollectionViewCell.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 02.05.2021.
//

import UIKit

final class PhotosCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Public properties
    
    static let reuseId = "PhotosCollectionViewCell"
    
    //MARK: - Private properties
    
    @IBOutlet private var photoImageView: UIImageView!
    @IBOutlet private var likeCintrol: LikeControl!
    
    //MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - Public methods
    
    func config (_ photo: String) {
        guard let url = URL(string: photo) else {return}
        self.photoImageView.kf.setImage(with: url)
        self.photoImageView.contentMode = .scaleAspectFill
        self.photoImageView.clipsToBounds = true
    }
}
