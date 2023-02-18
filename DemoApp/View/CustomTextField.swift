//
//  CustomTextField.swift
//  DemoApp
//
//  Created by Giorgi Katamadze on 18.02.23.
//

import UIKit
import SnapKit

class CustomTextField: UITextField {

    init(placeholder: String) {
       super.init(frame: .zero)
       let spacer = UIView()
       spacer.snp.makeConstraints { make in
           make.height.equalTo(50)
           make.width.equalTo(12)
       }
        leftView = spacer
        leftViewMode = .always
        self.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
     
       borderStyle = .none
       textColor = .white
       keyboardAppearance = .dark
       keyboardType = .emailAddress
       backgroundColor = UIColor(white: 1, alpha: 0.1)
       attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.8)])
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
}
