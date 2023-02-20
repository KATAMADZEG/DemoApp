//
//  ImageDetailCell.swift
//  DemoApp
//
//  Created by Giorgi Katamadze on 19.02.23.
//

import UIKit

class ImageDetailCell: UITableViewCell {

    //MARK: - Propeties
    private let largeImage : UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .yellow
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    private let imageSizeLabel : UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let imageTypeLabel : UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let imageTagsLabel : UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let viewsLabel : UILabel = {
        let label = UILabel()
        label.text = "asds"
        return label
    }()
    private let downloadsLabel : UILabel = {
        let label = UILabel()
        label.text = "asds"
        return label
    }()
    private let commentsLabel : UILabel = {
        let label = UILabel()
        label.text = "asds"
        return label
    }()
    
    private let likesLabel : UILabel = {
        let label = UILabel()
        label.text = "asds"
        return label
        
    }()
    
//MARK: - Helpers
    func configureDetailUI(with model:ImageDetailModel) {
        self.addSubview(largeImage)
        largeImage.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(model.imageInfo?.key == "imageInfoKey" ? 150 : 0 )
            make.centerX.equalTo(self.snp_centerXWithinMargins)
            make.top.equalTo(15)
            largeImage.layer.cornerRadius = 8
        }
        let stackView = UIStackView(arrangedSubviews: model.imageInfo?.key == "imageInfoKey" ? [imageSizeLabel,imageTypeLabel,imageTagsLabel] : [viewsLabel,downloadsLabel,commentsLabel,likesLabel] )
        
        stackView.axis = .vertical
        stackView.spacing = 5
        
        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(  model.imageInfo?.key == "imageInfoKey" ? largeImage.snp_bottomMargin : self.snp_topMargin).offset(15)
            make.left.equalTo(self.snp_leftMargin).inset(0)
            make.right.equalTo(self.snp_rightMargin).inset(0)
        }
        
        largeImage.sd_setImage(with: URL(string: model.imageInfo?.previewURL ?? ""))
        imageSizeLabel.text = "imageSize:\(model.imageInfo?.imageSize ?? 0)"
        imageTagsLabel.text = "tags:\(model.imageInfo?.tags ?? "")"
        imageTypeLabel.text = "type:\(model.imageInfo?.type ?? "")"
        viewsLabel.text = "views:\(model.userInfo?.views ?? 0)"
        downloadsLabel.text = "downloads:\(model.userInfo?.downloads ?? 0)"
        commentsLabel.text = "comments:\(model.userInfo?.comments ?? 0)"
        likesLabel.text = "likes:\(model.userInfo?.likes ?? 0)"

    }
}
