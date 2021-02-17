//
//  MainViewController.swift
//  skywebprotest
//
//  Created by vns on 17.02.2021.
//

import UIKit

class MainViewController: UIViewController {
    var mainViewModel  : MainViewModel? {
        didSet {
            print("Model is set")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set viewModel
        self.mainViewModel = MainViewModel()
        self.mainViewModel?.callback = { [weak self] in
            self?.refreshView()
        }
        
        // start getting data
        self.mainViewModel?.getPixabayJSONData()
        
        // Do any additional setup after loading the view.
    }
}

extension MainViewController {
    
    func refreshView() -> Void {
        
    }
}
