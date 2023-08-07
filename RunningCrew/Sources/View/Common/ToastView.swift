//
//  ToastView.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/28.
//

import UIKit
import SnapKit

final class ToastView: BaseView {
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.alpha = 1.0
        label.numberOfLines = 0
        return label
    }()
    
    override func addViews() {
        addSubview(messageLabel)
    }
    
    override func setConstraint() {
        messageLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    override func setViewStyle() {
        backgroundColor = .white
        layer.cornerRadius = 8
        clipsToBounds = true
    }
}

extension ToastView {
    func showMessage(message: String) {
        messageLabel.text = message
        
        UIView.animate(withDuration: 0.3,
                       delay: 1.5,
                       options: .curveEaseOut,
                       animations: { self.messageLabel.alpha = 0.0 },
                       completion: { _ in
            self.removeFromSuperview()
        })
    }
}
