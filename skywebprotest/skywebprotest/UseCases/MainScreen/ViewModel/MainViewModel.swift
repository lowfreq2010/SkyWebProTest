//
//  MainViewModel.swift
//  skywebprotest
//
//  Created by vns on 17.02.2021.
//

import Foundation

protocol MainViewModelProtocol {
    func numberOfSections() -> Int
    func numberOfRows(for section:Int) -> Int
}

class MainViewModel: MainViewModelProtocol {
    
    let mainModel = DataModel(with: PixabayJSONFetcher())
    var callback: () -> () = {} //binding callback for refreshing view with new data
    private var imageID: [Int] = [] // array with received images id
    
    // MARK: UIcollectionview delegate/source
    func numberOfSections()->Int {
        return 1
    }
    
    func numberOfRows(for section:Int)->Int {
        return self.imageID.count
    }
    
    // MARK: Other methods

    func getPixabayJSONData() {
        // ask model to load JSON data from server and download images from JSON
        self.mainModel.getData({[weak self] hits in
            let hitsID = hits.map({$0.id})
            self?.imageID.append(contentsOf: hitsID)
            let urlDictArray: [[Int:String]] = hits.map({[$0.id:$0.webformatURL]})
            let tupleArray: [(Int, String)] = urlDictArray.flatMap { $0 }
            let urlDictionary = Dictionary(tupleArray, uniquingKeysWith: { (first, last) in last })
            self?.mainModel.downloadImages(with: urlDictionary, completion: {
                self?.callback()
            })
        })
    }
    
    func cellViewModel(for row:Int) -> ImageCellViewModel? {
        
        let imageID = self.imageID[row]
        let imagePath = self.mainModel.getImage(with: imageID)
        return ImageCellViewModel(with: imagePath)
        
    }
}
