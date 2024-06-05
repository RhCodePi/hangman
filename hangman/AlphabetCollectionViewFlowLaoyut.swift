//
//  AlphabetCollectionViewFlowLaoyut.swift
//  hangman
//
//  Created by Trakya9 on 31.05.2024.
//

import UIKit

class AlphabetCollectionViewFlowLaoyut: UICollectionViewFlowLayout {
    
    
    let itemSpacing: CGFloat = 10.0
        override init() {
            super.init()
            self.minimumLineSpacing = itemSpacing
            self.minimumInteritemSpacing = itemSpacing
            self.sectionInset = UIEdgeInsets(top: itemSpacing, left: itemSpacing, bottom: itemSpacing, right: itemSpacing)
            self.itemSize = CGSize(width: 100.0, height: 100.0)
        }
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

}
