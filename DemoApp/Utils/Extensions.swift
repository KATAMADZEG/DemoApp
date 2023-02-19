//
//  Extensions.swift
//  DemoApp
//
//  Created by Giorgi Katamadze on 18.02.23.
//

import UIKit

extension UIButton {
    func attributedTitle(firstPart:String,secondPart:String){
        let atts : [NSAttributedString.Key:Any] = [.foregroundColor : UIColor(white: 1, alpha: 0.7),.font:UIFont.systemFont(ofSize: 16)]
        let attributeTitle = NSMutableAttributedString(string: firstPart , attributes: atts)
        let boldAtts : [NSAttributedString.Key:Any] = [.foregroundColor : UIColor(white: 1, alpha: 1),.font:UIFont.boldSystemFont(ofSize: 16)]
        attributeTitle.append(NSAttributedString(string: secondPart, attributes: boldAtts))
        setAttributedTitle(attributeTitle, for: .normal)
    }
}
extension UIViewController {
    func configureGradientLayer(){
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor,UIColor.systemBlue.cgColor]
        gradient.locations = [0, 1]
        gradient.frame = view.frame
        view.layer.addSublayer(gradient)
    }
}

extension String {
    func isValidEmail(_ email: Self) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

