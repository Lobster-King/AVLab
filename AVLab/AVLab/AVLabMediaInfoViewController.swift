//
//  AVLabMediaInfoViewController.swift
//  AVLab
//
//  Created by lobster on 2021/9/4.
//

import UIKit

class AVLabMediaInfoViewController: AVLabBaseViewController {
    let dataSource = [["General", []],["Video", []],["Audio", []]]
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenW / 2.0, height: 44)
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenW, height: screenH), collectionViewLayout: layout)
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        prepareDataSource()
    }
    
    func setupSubviews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
    func prepareDataSource() {
        
    }
    
}

extension AVLabMediaInfoViewController: UICollectionViewDelegate & UICollectionViewDataSource {
    //MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        return cell
    }
    
    
}
