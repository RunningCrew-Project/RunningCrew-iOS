//
//  RegionSelectButton.swift
//  RunningCrew
//
//  Created by Kim TaeSoo on 2023/04/15.
//

import UIKit

class RegionSelectButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    convenience init(actionNameArr: [String]) {
        self.init()
        var actionArr: [UIAction] = []
        self.backgroundColor = .white
        self.setTitleColor(.black, for: .normal)
        for title in actionNameArr {
            let action = UIAction(title: title, state: .off){ _ in
                self.setTitle(title, for: .normal)
            }
            actionArr.append(action)
        }
        self.menu = UIMenu(title: "", options: .displayInline, children: actionArr)
        
        self.changesSelectionAsPrimaryAction = true
        self.showsMenuAsPrimaryAction = true
//        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        self.backgroundColor = .lightGray
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
