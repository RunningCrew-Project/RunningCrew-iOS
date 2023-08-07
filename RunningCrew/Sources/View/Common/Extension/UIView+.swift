//
//  UIView+.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/03/10.
//

import UIKit

extension UIView {
    enum ToastViewPosition {
        case top
        case bottom
    }
    
    func setCorderRadius(cornerRadius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
    }
    
    func showToast(message: String, position: ToastViewPosition) {
        let toastView = ToastView(frame: CGRect(x: 0, y: 0, width: self.frame.width * 0.95, height: self.frame.height * 0.1))
        let y = position == .top ? self.safeAreaLayoutGuide.layoutFrame.origin.y + self.frame.height * 0.1 : self.frame.height * 0.9
        
        self.addSubview(toastView)
        toastView.center = CGPoint(x: self.frame.size.width / 2, y: y)
        toastView.showMessage(message: message)
    }
}
