//
//  File.swift
//  
//
//  Created by Ali Hasanoğlu on 24.09.2021.
//

import UIKit

public extension UITableView {
    func registerNib(_ type: UITableViewCell.Type, bundle: Bundle) {
        register(
            UINib(nibName: type.cellIdentifier, bundle: bundle),
            forCellReuseIdentifier: type.cellIdentifier
        )
    }

    func dequeueCell<CellType: UITableViewCell>(type: CellType.Type, indexPath: IndexPath) -> CellType {
        guard let cell = dequeueReusableCell(
            withIdentifier: CellType.cellIdentifier,
            for: indexPath) as? CellType
        else {
            fatalError("Wrong type of cell \(type)")
        }
        return cell
    }
}
