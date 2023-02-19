//
//  MainPageCell.swift
//  DemoApp
//
//  Created by Giorgi Katamadze on 19.02.23.
//

import UIKit

class MainPageCell: UITableViewCell {

    //MARK: - Properties
    private let mainImageView : UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        return iv
    }()
    
    private let userNameLabel : UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    
//MARK: - Helpers
    func configureMainPageCellUI() {
        
        self.addSubview(mainImageView)
        mainImageView.snp.makeConstraints { make in
            make.right.equalTo(-12)
            make.left.equalTo(12)
            make.height.equalTo(160)
            make.top.equalTo(6)
            mainImageView.layer.cornerRadius = 8
        }
        mainImageView.backgroundColor  = .red
        self.addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp_bottomMargin).offset(12)
            make.left.equalToSuperview().offset(15)
        }
        userNameLabel.text  = "aavtoris saxeli"
    }
}
