//
//  UICollectionView+Extension.swift
//  
//
//  Created by Ali Hasanoğlu on 20.09.2021.
//

import UIKit

public extension UICollectionView {
    
    func registerNib(_ type: UICollectionViewCell.Type, bundle: Bundle) {
        register(
            UINib(nibName: type.cellIdentifier, bundle: bundle),
            forCellWithReuseIdentifier: type.cellIdentifier
        )
    }
    
    func dequeueCell<CellType: UICollectionViewCell>(type: CellType.Type, indexPath: IndexPath) -> CellType {
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: CellType.cellIdentifier, for: indexPath
        ) as? CellType else {
            fatalError("Wrong type of cell \(type)")
        }
        return cell
    }
    
    func addFooter() {
        self.register(
            CollectionViewFooter.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: "Footer"
        )
        (self.collectionViewLayout as? UICollectionViewFlowLayout)?.footerReferenceSize = CGSize(
            width: self.bounds.width,
            height: 50
        )
    }
}
