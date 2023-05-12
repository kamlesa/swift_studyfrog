//
//  UIViewController+displayMessage.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 12/5/2023.
//

import Foundation

//
//  UIViewController+displayMessage.swift
//  3178-LAB3
//
//  Created by Anika Kamleshwaran on 21/3/2023.
//

import Foundation
import UIKit
extension UIViewController {
    func displayMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
}
