//
//  CharacterInformationCell.swift
//  Marvel
//
//  Created by Ali Hasanoğlu on 24.09.2021.
//

import UIKit

class CharacterInformationCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var infoStack: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(with items: [String], title: String) {
        labelTitle.text = title
        infoStack.removeAllArrangedSubviews()
        for item in items {
            let label = UILabel()
            label.textColor = UIColor(red: 31/255, green: 31/255, blue: 31/255, alpha: 0.9)
            label.text = item
            label.font = UIFont(name: "Halvetica", size: 14)
            infoStack.addArrangedSubview(label)
        }
    }
}
