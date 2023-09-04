//
//  MyPageMyRunningCollectionViewCell.swift
//  RunningCrew
//
//  Created by Dongwan Ryoo on 2023/04/07.
//

import UIKit

class MyPageMyRunningCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MyPageMyRunningCollectionViewCell"

    @IBOutlet weak var runningTitle: UILabel!
    @IBOutlet weak var runningDistance: UILabel!
    @IBOutlet weak var runningDate: UILabel!
    @IBOutlet weak var runningTime: UILabel!
    @IBOutlet weak var runningEverage: UILabel!
    
    @IBOutlet weak var runningPlace: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setShadow()
    }

    func setCell () {
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
    }
    
    func setShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.masksToBounds = false
    }

}
