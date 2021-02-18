//
//  MainCollectionViewController.swift
//  skywebprotest
//
//  Created by vns on 18.02.2021.
//

import UIKit

private let reuseIdentifier = "ImageCell"

class MainCollectionViewController: UIViewController {
    
    var mainViewModel  : MainViewModel?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        let nibCell :UINib = UINib(nibName: "MainCVCell", bundle: nil)
        self.collectionView.register(nibCell, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        if let flowLayout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            
        }

        // Do any additional setup after loading the view.
        self.mainViewModel = MainViewModel()
        self.mainViewModel?.callback = { [weak self] in
            self?.refreshView()
        }
        
        // start getting data
        self.mainViewModel?.getPixabayJSONData()
        self.refreshView()
    }


    // MARK: UICollectionViewDataSource

}


extension MainCollectionViewController {
    
    func refreshView() -> Void {
        
        self.collectionView.reloadData()
    }
}

extension MainCollectionViewController: UICollectionViewDelegate {
    
}

extension MainCollectionViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.mainViewModel?.numberOfSections() ?? 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.mainViewModel?.numberOfRows(for: section) ?? 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MainCVCell else {return UICollectionViewCell()}
        guard let cellViewModel = self.mainViewModel?.cellViewModel(for: indexPath.row) else {return UICollectionViewCell()}
        cell.congigure(with: cellViewModel)
        
        return cell
    }
}

