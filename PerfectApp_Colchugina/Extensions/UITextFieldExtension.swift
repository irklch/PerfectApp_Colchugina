//
//  UITextFieldExtension.swift
//  PerfectApp_Colchugina
//
//  Created by Ирина Кольчугина on 25.04.2021.
//

import  UIKit

extension UITextField {
    func useUnderline(_ color: UIColor, _ borderSize: CGFloat) -> Void {
    let border = CALayer()
        let borderWidth = borderSize// Border Width
    border.borderColor = color.cgColor
        border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
    border.borderWidth = borderWidth
    self.layer.addSublayer(border)
    self.layer.masksToBounds = true
  }
}


