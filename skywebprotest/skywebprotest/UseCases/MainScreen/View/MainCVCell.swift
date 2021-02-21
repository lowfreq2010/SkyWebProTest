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
    
    func configure(with viewModel: ImageCellViewModel) {
        guard let img = viewModel.image else {return}
        self.imageView.image = img
    }
    
    func setupConstraints() -> Void {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
