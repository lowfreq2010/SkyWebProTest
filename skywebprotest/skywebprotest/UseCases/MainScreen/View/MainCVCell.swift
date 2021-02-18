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
        // Initialization code
    }
    
    func congigure(with viewModel: ImageCellViewModel) {
        guard let img = viewModel.image else {return}
        self.imageView.image = img
    }
}
