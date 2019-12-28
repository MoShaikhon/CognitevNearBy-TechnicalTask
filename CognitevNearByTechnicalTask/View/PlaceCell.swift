//
//  PlaceCell.swift
//  CognitevNearByTechnicalTask
//
//  Created by Mohamed Shaikhon on 12/23/19.
//  Copyright © 2019 Mohamed Shaikhon. All rights reserved.
//

import UIKit
import Kingfisher

protocol PresentingCellDataSource {
    var placeName: String { get set }
    var placeAddress: String { get set }
    var placePhoto: String { get set }
    var id: String {get set}
}
struct PresentedCellDataSource: PresentingCellDataSource {
    var id: String
    var placeName: String
    var placeAddress: String
    var placePhoto: String
    
}

class PlaceCell: UITableViewCell {
    
    
    private lazy var placeNameLabel: UILabel = {
        let label = UILabel()
        label.enableAutoLayout()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.sizeToFit()
        label.text = "capXX: cap the photo with a width or height of XX. (whichever is larger). Scales they"
        return label
    }()
    
    private lazy var placeAddressLabel: UILabel = {
        let label = UILabel()
        label.enableAutoLayout()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.text = "capXX: cap the photo with a width or height of XX. (whichever is larger). Scales the o"
        return label
    }()
    
    private lazy var placePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.enableAutoLayout()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    private lazy var placeLabelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.enableAutoLayout()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.addArrangedSubview(placeNameLabel)
        stackView.addArrangedSubview(placeAddressLabel)
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        anchorViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func anchorViews() {
        anchorPlacePhotoImageView()
        anchorPlaceLabelsStackView()
    }
    private func anchorPlacePhotoImageView() {
        addSubview(placePhotoImageView)
        placePhotoImageView.anchorYAxis(top: topAnchor, topConstant: 15)
        placePhotoImageView.anchorXAxis(leading: leadingAnchor, leadingConstant: 15)
        placePhotoImageView.anchorWidth(equalToConstant: 100)
        placePhotoImageView.anchorHeight(equalToConstant: 100)
        //        placePhotoImageView.anchorYAxis(top: topAnchor, bottom: bottomAnchor, topConstant: 15, bottomConstant: 15)
        //        placePhotoImageView.anchorXAxis(leading: leadingAnchor, leadingConstant: 15)
        //        placePhotoImageView.anchorhei
    }
    private func updatePlacePhotoImageViewSize(by imageSize: CGSize) {
        placePhotoImageView.anchorWidth(equalToConstant: imageSize.width)
        placePhotoImageView.anchorHeight(equalToConstant: imageSize.height)
    }
    
    func populateCell(with presentedCellData: PresentingCellDataSource) {
        placeNameLabel.text = presentedCellData.placeName
        placePhotoImageView.kf.setImage(with: URL(string: presentedCellData.placePhoto))
        placeAddressLabel.text = presentedCellData.placeAddress
    }
    
    private func anchorPlaceLabelsStackView() {
        addSubview(placeLabelsStackView)
        placeLabelsStackView.anchorXAxis(leading: placePhotoImageView.trailingAnchor, trailing: trailingAnchor, leadingConstant: 15, trailingConstant: -15)
        placeLabelsStackView.anchorYAxis(top: topAnchor, bottom: bottomAnchor, topConstant: 15, bottomConstant: -15)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
