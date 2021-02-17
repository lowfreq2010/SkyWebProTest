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
    func getTitle(for section:Int) -> String?
    
}

class MainViewModel: MainViewModelProtocol {
    
    let mainModel = DataModel(with: PixabayJSONFetcher())
    var callback: () -> () = {} //binding callback for refreshing view with new data
    var imageID: [Int] = [] // array with revceived images id

    
    // MARK: Service class objects
    
    //let nsudProcessor: CurrencyListNSUD = CurrencyListNSUD(with: "selectedCurrencies", value: [])
    
    // MARK: UITableview delegate/source
    func numberOfSections()->Int {
        // return self.selectedCurrencies.count == 0 ? 1 : 2
        return 2
    }
    
    func numberOfRows(for section:Int)->Int {
        var numOfRows: Int = 0
        
//        switch section {
//        case 1:
//            //numOfRows = self.currencies.count
//        default:
//           // numOfRows = self.selectedCurrencies.count
//        }
        return numOfRows
    }
    
    func getTitle(for section:Int) -> String? {
        var title: String?
        
        switch section {
        case 1:
            title = NSLocalizedString("COMMONLIST", comment: "")
        default:
            title = NSLocalizedString("SELECTEDLIST", comment: "")
        }
        return title
    }
    
    // MARK: Convenience methods
    

    func getPixabayJSONData() {
        // ask model to load data from server and prepare data for view
        self.mainModel.getData({[weak self] hits in
            let hitsID = hits.map({$0.id})
            self?.imageID.append(contentsOf: hitsID)
            let urlDictArray: [[Int:String]] = hits.map({[$0.id:$0.largeImageURL]})
            let tupleArray: [(Int, String)] = urlDictArray.flatMap { $0 }
            let urlDictionary = Dictionary(tupleArray, uniquingKeysWith: { (first, last) in last })
            self?.mainModel.downloadImages(with: urlDictionary, completion: {
                self?.callback()
            })
        })
    }
}
