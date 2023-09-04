//
//  CrewAlarmViewCell.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/18.
//

import UIKit

final class CrewAlarmViewCell: UICollectionViewCell {
    
    @IBOutlet weak var crewIconImageView: UIImageView!
    @IBOutlet weak var alarmTypeLabel: UILabel!
    @IBOutlet weak var alarmTitleLabel: UILabel!
    @IBOutlet weak var alarmCrewTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    static let identifier = "CrewAlarmReusableCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        imageViewMakeCircle()
    }
    
    func imageViewMakeCircle() {
        crewIconImageView.layer.cornerRadius = crewIconImageView.frame.width / 2.0
        crewIconImageView.layer.borderWidth = 1
        crewIconImageView.layer.borderColor = UIColor.darkGray.cgColor
        crewIconImageView.clipsToBounds = true
    }
    
    func configure(content: NotificationContent) {
        let url = URL(string: content.crewImgURL)
        crewIconImageView.kf.setImage(with: url)
        
        alarmTypeLabel.text = content.type
        alarmTitleLabel.text = content.title
        alarmCrewTitleLabel.text = content.crewName
        dateLabel.text = content.createdDate
    }
}
