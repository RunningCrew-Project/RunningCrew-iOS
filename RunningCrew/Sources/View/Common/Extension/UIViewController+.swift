//
//  UIViewController+.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/03/09.
//

import Foundation
import UIKit

extension UIViewController {
    
    func scrollViewKeyboardHiddenSetting(scrollView: UIScrollView) {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapScrollView))
        scrollView.addGestureRecognizer(gesture)
    }
    
    @objc func tapScrollView() {
        self.view.endEditing(true)
    }
    
    func showAlert(title: String, message: String, actions: [UIAlertAction]) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        actions.forEach { action in alertVC.addAction(action) }
        
        present(alertVC, animated: false)
    }
}
