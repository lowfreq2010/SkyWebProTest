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
    var isLoading: Bool = false
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setupCollectionView()
        self.mainViewModel = MainViewModel()
        self.mainViewModel?.callback = { [weak self] in
            self?.refreshView()
        }
        
        // start getting data
        DispatchQueue.global().async {[weak self] in
            self?.mainViewModel?.getPixabayJSONData()
        }
        self.collectionView.reloadData()
    }
}


extension MainCollectionViewController {
    
    func refreshView() -> Void {
        DispatchQueue.main.async {
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.reloadData()
            self.isLoading = false
        }
    }
    
    func setupCollectionView() {
        // Register cell classes
        let nibCell :UINib = UINib(nibName: "MainCVCell", bundle: nil)
        self.collectionView.register(nibCell, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        if let flowLayout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
    }
    
    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            DispatchQueue.global().async {[weak self] in
                self?.mainViewModel?.getPixabayJSONData()
            }
        }
    }
}

// MARK: UICollectionViewDelegate
extension MainCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let section = indexPath.section
        let numberRows = self.mainViewModel?.numberOfRows(for: section) ?? 1
        if (indexPath.row == numberRows - 10 && !self.isLoading) {
            loadMoreData()
        }
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout
extension  MainCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        return size
        
    }
    
}

// MARK: UICollectionViewDataSource
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
        cell.configure(with: cellViewModel)
        
        return cell
    }
}

