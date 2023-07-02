//
//  CrewGenerateTextField.swift
//  RunningCrew
//
//  Created by Kim TaeSoo on 2023/04/15.
//

import UIKit

class GenerateTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(placeholder: String?) {
        self.init()
        self.layer.cornerRadius = 8
        self.backgroundColor = .lightGray
        self.placeholder = placeholder
        self.textColor = .darkGray
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class GenerateTextFieldView: UIView {
    var tf = GenerateTextField()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .lightGray
        self.layer.cornerRadius = 8
        setupLayout()
    }
    
    convenience init(placeholder: String?) {
        self.init()
        tf.placeholder = placeholder
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupLayout() {
        let edges: CGFloat = 16

        self.addSubview(tf)
        tf.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide).inset(edges)
        }
    }
}
