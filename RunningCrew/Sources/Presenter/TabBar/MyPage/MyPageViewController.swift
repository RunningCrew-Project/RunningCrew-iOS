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
    
    lazy var profileStackview:UIStackView = {
        let stackview = UIStackView()
        stackview.backgroundColor = .white
        stackview.autoresizingMask = [.flexibleTopMargin, .flexibleHeight]
        
        return stackview
    }()
    
    lazy var profileImage:UIImageView = {
        let iamgeView = UIImageView()
        iamgeView.image = UIImage(systemName: "person.circle")
        
        return iamgeView
    }()
    
    lazy var profileTitle:UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        
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

    
    //MARK: - Set UI
    
    func setAddView(){
        view.addSubview(profileStackview)
        profileStackview.addArrangedSubview(profileImage)
        profileStackview.addArrangedSubview(profileTitle)
        profileStackview.addArrangedSubview(profileChagneButton)
    }
    
    func setView() {
        view.backgroundColor = .white
    }
    
    func setprofileStackview() {
        profileStackview.axis = .horizontal
        profileStackview.alignment = .trailing
    }
    
    
    func setConstraint() {
        profileStackviewConstraint()
        profileImageConstraint()
    }
    
    func profileStackviewConstraint() {
        profileStackview.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(view.snp.height).multipliedBy(CGFloat(Double(166) / Double(1624)))
        }
    }
    
    func profileImageConstraint() {
        profileImage.snp.makeConstraints { make in
            make.height.width.equalTo(view.snp.height).multipliedBy(CGFloat(Double(166) / Double(1624)))
        }
    }
    
    
    func setNavigationBar() {
        let setImage = UIImage(systemName: "gearshape")
        let setButton = UIBarButtonItem(image: setImage, style: .plain, target: self, action: nil)
        self.navigationItem.title = "마이페이지"
        self.navigationItem.rightBarButtonItem = setButton
    }

    //샘플 주석 추가

}
