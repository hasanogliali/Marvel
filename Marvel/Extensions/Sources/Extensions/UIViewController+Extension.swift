//
//  File.swift
//  
//
//  Created by Ali Hasanoğlu on 25.09.2021.
//

import UIKit

public extension UIViewController {
    func presentAlert(title: String = "Ooops!", _ message: String, buttonTitle: String = "OK") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .cancel)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
