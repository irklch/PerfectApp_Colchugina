//
//  FriendPhotosController.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 02.05.2021.
//

import UIKit
import Kingfisher

class FriendPhotosViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Private Property
    
    @IBOutlet var photosCollectoinView: UICollectionView!
    private var selectedPhoto = 0
    private var photoList = [PhotosFriend]()
    var selectedFriend = Friends()
    private var viewPhoto = UIView()
    private var photoImageView = UIImageView()
    private var backButton = UIButton(type: .system)
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate()
        getPhotoList()
    }
    
    // MARK: - Private methods
    
    private func getPhotoList() {
        let vkRequest = VKRequests()
        let mapping = MappingJson()
        vkRequest.getFriendsPhotoList(idFriend: String(selectedFriend.id)) { [weak self] result in
            guard let self = self else {return}
            switch result{
            case .failure(let error):
                print (error)
            case .success(let photos):
                self.photoList = mapping.createNewPhotoStruct(oldStruct: photos.response.items)
                DispatchQueue.main.async {
                    self.photosCollectoinView.reloadData()
                }
            }
        }
    }
    
    private func openPhoto (indexPhoto: Int) {
        
        view.addSubview(viewPhoto)
        viewPhoto.alpha = 0
        viewPhoto.backgroundColor = .black
        viewPhoto.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewPhoto.topAnchor.constraint(equalTo: view.topAnchor),
            viewPhoto.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            viewPhoto.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            viewPhoto.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        viewPhoto.addSubview(photoImageView)
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoImageView.centerYAnchor.constraint(equalTo: viewPhoto.centerYAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: viewPhoto.trailingAnchor, constant: 0),
            photoImageView.leadingAnchor.constraint(equalTo: viewPhoto.leadingAnchor, constant: 0),
            photoImageView.heightAnchor.constraint(equalToConstant: 500)
        ])
        
        guard let url = URL(string: photoList[indexPhoto].url) else {return}
        photoImageView.kf.setImage(with: url)
        photoImageView.clipsToBounds = true
        photoImageView.contentMode = .scaleAspectFill
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.viewPhoto.alpha = 1
            
        }, completion: nil)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(photoPan))
        let swipeUp = UISwipeGestureRecognizer()
        swipeUp.direction = [.up, .down]
        swipeUp.delegate = self
        swipeUp.addTarget(self, action: #selector(swipeUpGesture))
        viewPhoto.addGestureRecognizer(swipeUp)
        viewPhoto.addGestureRecognizer(panGestureRecognizer)
    }
    
    //свайп вниз и вверх для закрытия фото
    @objc private func swipeUpGesture(_ swipeUp: UISwipeGestureRecognizer) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.viewPhoto.alpha = 0
        }, completion: { completion in
            self.viewPhoto.removeFromSuperview()
            self.viewPhoto.alpha = 1
        })
    }
    
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
    //перелистывание фото
    @objc func photoPan ( _ recognizer: UIPanGestureRecognizer) {
        let photoCount = photoList.count
        var fullSwipe: CGFloat = 0
        switch recognizer.state {
        
        case .changed:
            photoImageView.transform = CGAffineTransform(translationX: recognizer.translation(in: view).x, y: 0)
            
            //если последняя фотография - стоп перелистывания
            if recognizer.translation(in: view).x < 0 && selectedPhoto == photoCount - 1 {
                if recognizer.translation(in: view).x > -50 {
                    return self.photoImageView.transform = CGAffineTransform(translationX: recognizer.translation(in: view).x, y: 0)
                } else {
                    return self.photoImageView.transform = CGAffineTransform(translationX: -50, y: 0)
                }
            }
            
            //если первая фотография - стоп перелистывания
            else if recognizer.translation(in: view).x > 0 && selectedPhoto == 0  {
                if recognizer.translation(in: view).x < 50 {
                    return self.photoImageView.transform = CGAffineTransform(translationX: recognizer.translation(in: view).x, y: 0)
                }
                else {
                    return self.photoImageView.transform = CGAffineTransform(translationX: 50, y: 0)
                }
            }
            
        case .ended:
            
            // возвращает фото в исходное положение, если фото первое или последнее
            if (recognizer.translation(in: view).x < 0 && selectedPhoto == photoCount - 1) || (recognizer.translation(in: view).x > 0 && selectedPhoto == 0) {
                return UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                    self.photoImageView.transform = .identity
                }, completion: nil)
            }
            
            //возвращает фото в исходное положение, если недостаточно сильно смахнули
            guard recognizer.translation(in: view).x > 50 || recognizer.translation(in: view).x < -50 else {
                return UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                    self.photoImageView.transform = .identity
                }, completion: nil)
            }
            
            //определяет направление перелистывания фото и изменяет индекс фотографии
            if recognizer.translation(in: view).x < 0 {
                fullSwipe = recognizer.translation(in: view).x - 300
                selectedPhoto += 1
            }
            else {
                fullSwipe = recognizer.translation(in: view).x + 300
                selectedPhoto -= 1
            }
            
            //перелистывает фото
            UIView.animate(withDuration: 0.3) {[self] in
                self.photoImageView.transform = CGAffineTransform(translationX: fullSwipe, y: 0)
            } completion: { _ in
                guard let url = URL(string: self.photoList[self.selectedPhoto].url) else {return}
                self.photoImageView.kf.setImage(with: url)
                self.photoImageView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
                UIView.animate(
                    withDuration: 0.3,
                    delay: 0,
                    usingSpringWithDamping: 0.5,
                    initialSpringVelocity: 0.2,
                    options: .curveEaseInOut,
                    animations: {
                        self.photoImageView.transform = .identity
                    },
                    completion: nil)
            }
        default:
            break
        }
    }
}

//MARK:- Extesion

extension FriendPhotosViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    private func delegate() {
        self.photosCollectoinView.delegate = self
        self.photosCollectoinView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.reuseId, for: indexPath) as! PhotosCollectionViewCell
        cell.config(photoList[indexPath.row].url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let url = URL(string: photoList[indexPath.row].url) else {return}
        photoImageView.kf.setImage(with: url)
        openPhoto(indexPhoto: indexPath.row)
        selectedPhoto = indexPath.row
    }
}
