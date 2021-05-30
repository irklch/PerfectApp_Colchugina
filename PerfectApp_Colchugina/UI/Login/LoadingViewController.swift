//
//  LoadingViewController.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 15.05.2021.
//

import UIKit

class LoadingViewController: UIViewController {
    let point1 = UIView()
    let point2 = UIView()
    let point3 = UIView()
    let pointSize = CGFloat(17)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        playAnimation()
        
        
    }
    var topConstraint = NSLayoutConstraint()
    func setViews() {
        
        self.view.addSubview(point2)
        point2.layer.cornerRadius = pointSize/2
        point2.layer.backgroundColor = UIColor.systemGray.cgColor
        point2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            point2.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            point2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            point2.widthAnchor.constraint(equalToConstant: pointSize),
            point2.heightAnchor.constraint(equalToConstant: pointSize)
        ])
        topConstraint = point2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)

        
        self.view.addSubview(point1)
        point1.layer.cornerRadius = pointSize/2
        point1.layer.backgroundColor = UIColor.systemGray.cgColor
        point1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            point1.trailingAnchor.constraint(equalTo: point2.leadingAnchor, constant: -10),
            point1.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            point1.widthAnchor.constraint(equalToConstant: pointSize),
            point1.heightAnchor.constraint(equalToConstant: pointSize)
        ])
        
        self.view.addSubview(point3)
        point3.layer.cornerRadius = pointSize/2
        point3.layer.backgroundColor = UIColor.systemGray.cgColor
        point3.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            point3.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            point3.leadingAnchor.constraint(equalTo: point2.trailingAnchor, constant: 10),
            point3.widthAnchor.constraint(equalToConstant: pointSize),
            point3.heightAnchor.constraint(equalToConstant: pointSize)
        ])
        point1.backgroundColor = UIColor.white
        point2.backgroundColor = UIColor.white
        point3.backgroundColor = UIColor.white
        
    }
    
    
    func playAnimation() {
        
        UIView.animate(withDuration: 4,
                       delay: 5,
                       options: [.curveEaseInOut]) {
            
                self.point1.backgroundColor = UIColor.black
            
        } completion: { comleted in
            
            UIView.animate(withDuration: 0,
                           delay: 0.5,
                           options: [.curveEaseInOut]) {
                self.point2.backgroundColor = UIColor.black
            } completion: { comleted in
                
                UIView.animate(withDuration: 0,
                               delay: 0.5,
                               options: [.curveEaseInOut]) {
                    self.point3.backgroundColor = UIColor.black
                } completion: { completion in
                    
                    UIView.animate(withDuration: 0,
                                   delay: 0.1,
                                   options: [.curveEaseInOut],
                                   animations: {
                                    self.topConstraint.constant += 100
                                    self.view.setNeedsLayout()
                                   },
                                   completion: {_ in
                                    self.performSegue(withIdentifier: "LoadingViewController", sender: nil)
                                    
                                   })
                }

            }

        }

    }

}
