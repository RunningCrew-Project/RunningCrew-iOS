//
//  MyRunningCollectionViewCell.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/18.
//

import UIKit

final class MyRunningCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var monthDateLabel: UILabel!
    @IBOutlet weak var datDateLabel: UILabel!
    @IBOutlet weak var hourDateLabel: UILabel!
    @IBOutlet weak var runningTitleLabel: UILabel!
    @IBOutlet weak var personCountLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var runningStatusView: UIView!
    @IBOutlet weak var runningStatusLabel: UILabel!
    
    static let identifier = "MyRunningCollectionReusableCell"
    
    var canRunning: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        setShadow()
        topView.layer.cornerRadius = 14
        topView.clipsToBounds = true
    }

    func setShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.masksToBounds = false
    }
    
    func configure(data: RunningNotice) {
        data.runningDateTime
        
        data.runningMemberCount
    }
}
