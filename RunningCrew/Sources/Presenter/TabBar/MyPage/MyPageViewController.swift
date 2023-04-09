//
//  MyPageViewController.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/13.
//

import UIKit
import SnapKit

class MyPageViewController: UIViewController {
    //MARK: - UI ProPerties
    
    lazy var profileView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
//        stackview.autoresizingMask = [.flexibleTopMargin, .flexibleHeight]
        
        return view
    }()
    
    lazy var profileImage:UIImageView = {
        let iamgeView = UIImageView()
        iamgeView.image = UIImage(systemName: "person.circle")
        
        return iamgeView
    }()
    
    lazy var container:UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .center
        
        return stackview
    }()
    
    lazy var profileTitle:UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.font = UIFont(name: "NotoSansKR-Medium", size: 24)
        
        return label
    }()
    
    
    lazy var profileChagneButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil.circle"), for: .normal)
        
        return button
    }()

    
    //MARK: - Properties

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setAddView()
        setView()
        setConstraint()
    }
    //MARK: - Define Method
    func setNavigationBar() {
        let setImage = UIImage(systemName: "gearshape")
        let setButton = UIBarButtonItem(image: setImage, style: .plain, target: self, action: nil)
        self.navigationItem.title = "마이페이지"
        self.navigationItem.rightBarButtonItem = setButton
    }

    
    //MARK: - Set UI
    
    func setAddView(){
        view.addSubview(profileView)
        profileView.addSubview(profileImage)
        container.addArrangedSubview(profileTitle)
        container.addArrangedSubview(profileChagneButton)
        profileView.addSubview(container)
    }
    
    func setView() {
        view.backgroundColor = .white
    }
    
    
    func setConstraint() {
        profileViewConstraint()
        profileImageConstraint()
        containercConstraint()
        profileChagneButtonConstraint()
    }
    
    func profileViewConstraint() {
        profileView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(view.snp.height).multipliedBy(CGFloat(Double(166) / Double(1624)))
        }
    }
    
    func profileImageConstraint() {
        profileImage.snp.makeConstraints { make in
            make.height.width.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(CGFloat(Double(166) / Double(1624)))
            make.leading.equalTo(profileView.snp.leading).offset(48)
            make.centerY.equalTo(profileView.snp.centerY)
        }
    }
    
    func containercConstraint() {
        container.snp.makeConstraints { make in
            make.centerY.equalTo(profileView.snp.centerY)
            make.centerX.equalTo(profileView.snp.centerX)
        }
    }

    
    func profileChagneButtonConstraint() {
        profileChagneButton.snp.makeConstraints { make in
            make.height.width.equalTo(view.snp.height).multipliedBy(CGFloat(Double(65) / Double(1624)))
        }
        
    }
    
  
    

}
