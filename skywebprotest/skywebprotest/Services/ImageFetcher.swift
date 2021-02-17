//
//  ImageFetcher.swift
//  skywebprotest
//
//  Created by vns on 17.02.2021.
//

import Foundation
import UIKit

class ImageFetcher: NSObject {
    
    func fetch(with imagesDict: [Int:String], completion: @escaping () -> Void) {

        let downloadGroup = DispatchGroup()
        for item in imagesDict {
            guard let url = URL(string: item.value) else {return}
            let imageID: String = String(describing: item.key)
            downloadGroup.enter()
            URLSession.shared.dataTask(with: url) { data, response, error in
                // save received data as image
                guard let data = data else {return}
                let _ = ImageService.saveImage(from: UIImage(data: data), to: imageID)
                downloadGroup.leave()
            }.resume()
        }
        
        downloadGroup.notify(queue: DispatchQueue.main) {
          completion()
        }
    }
}
