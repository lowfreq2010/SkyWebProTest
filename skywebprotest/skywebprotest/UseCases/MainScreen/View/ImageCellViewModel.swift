//
//  ImageCellViewModel.swift
//  skywebprotest
//
//  Created by vns on 18.02.2021.
//

import Foundation
import UIKit

class ImageCellViewModel: NSObject {
    var image: UIImage?
    
    init(with imagePath: String) {
        self.image = UIImage(contentsOfFile: imagePath)
    }
}
