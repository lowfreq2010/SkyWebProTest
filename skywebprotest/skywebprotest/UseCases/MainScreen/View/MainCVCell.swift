//
//  MainCVCell.swift
//  skywebprotest
//
//  Created by vns on 18.02.2021.
//

import UIKit

class MainCVCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollerView: UIScrollView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupConstraints()
        
    }
    
    func configure(with viewModel: ImageCellViewModel) {
        guard let img = viewModel.image else {return}
        self.imageView.image = img
        self.scrollerView.contentSize = img.size
    }
    
    func setupConstraints() -> Void {
        scrollerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            scrollerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            scrollerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        imageView.translatesAutoresizingMaskIntoConstraints = false // Make sure constraints won't interfere with autoresizing mask
        NSLayoutConstraint.activate(
            [
                imageView.leftAnchor.constraint(equalTo: scrollerView.leftAnchor),    // attaching to the left
                imageView.topAnchor.constraint(equalTo: scrollerView.topAnchor),      // attaching to the top
                imageView.rightAnchor.constraint(equalTo: scrollerView.rightAnchor),  // attaching to the right
                imageView.bottomAnchor.constraint(equalTo: scrollerView.bottomAnchor) // attaching to the bottom
            ]
        )
        
    }
}
