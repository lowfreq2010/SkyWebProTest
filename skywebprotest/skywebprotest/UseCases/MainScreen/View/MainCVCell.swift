//
//  MainCVCell.swift
//  skywebprotest
//
//  Created by vns on 18.02.2021.
//

import UIKit

class MainCVCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupConstraints()
        
    }
}


extension MainCVCell {
    
    func configure(with viewModel: ImageCellViewModel) {
        guard let img = viewModel.image else {return}
        self.imageView.image = img
        let width = img.size.width
        let height = img.size.height
        let ratio = (width > height) ? width/height : height/width
        let imageViewHeight = self.imageView.frame.size.height*ratio
        let imageViewWidth = self.imageView.frame.size.width
        let imageViewSize = CGSize(width: imageViewWidth, height: imageViewHeight)
        self.imageView.frame.size = imageViewSize
        
    }
    
    func setupConstraints() -> Void {
        
//        self.imageView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            self.imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
//            self.imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
//            self.imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            self.imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        ])
    }
}
