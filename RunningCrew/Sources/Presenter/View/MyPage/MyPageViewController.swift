//
//  MyPageViewController.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/02/13.
//

import UIKit
import SnapKit

class MyPageViewController: CustomTopTabBarController {
    //MARK: - UI ProPerties
    
    
    lazy var profileView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
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
        button.addTarget(self, action: #selector(profileChagneButtonTapped(_:)), for: .touchUpInside)
        
        return button
    }()

    
    lazy var topTabBarContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    //MARK: - Properties


    //MARK: - Define Method
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setAddView()
        setView()
        setConstraint()
        topTabBarMenu.delegate = self
    }
    
    func setNavigationBar() {
        let setImage = UIImage(systemName: "gearshape") 
        let setButton = UIBarButtonItem(image: setImage, style: .plain, target: self, action: nil)
        self.navigationItem.title = "마이페이지"
        self.navigationItem.rightBarButtonItem = setButton
    }
    
    @objc func profileChagneButtonTapped(_ sender: UIButton) {
        let destinationViewController = ProfileChnageViewController()
        self.navigationController?.pushViewController(destinationViewController, animated: true)
//        present(destinationViewController, animated: true)
    }

    
    //MARK: - Set UI
    
    func setAddView(){
        view.addSubview(profileView)
        profileView.addSubview(profileImage)
        container.addArrangedSubview(profileTitle)
        container.addArrangedSubview(profileChagneButton)
        profileView.addSubview(container)
        view.addSubview(topTabBarContainer)
        topTabBarContainer.addSubview(topTabBarMenu)
        view.addSubview(pageView)
    }
    
    func setView() {
        view.backgroundColor = .white
    }
    
    
    func setConstraint() {
        profileViewConstraint()
        profileImageConstraint()
        containercConstraint()
        profileChagneButtonConstraint()
        setTopTabContainer()
        setTopTabBarConstraint()
        setPageViewConstraint()
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
            make.height.width.equalTo(84)
            make.leading.equalTo(profileView.snp.leading).offset(48)
            make.centerY.equalTo(profileView.snp.centerY)
        }
    }
    
    func containercConstraint() {
        container.snp.makeConstraints { make in
            make.centerY.equalTo(profileView.snp.centerY)
            make.leading.equalToSuperview().offset(155)
        }
    }

    
    func profileChagneButtonConstraint() {
        profileChagneButton.snp.makeConstraints { make in
            make.height.width.equalTo(view.snp.height).multipliedBy(CGFloat(Double(65) / Double(1624)))
        }
        
    }

    
    func setTopTabContainer() {
        NSLayoutConstraint.activate([

            topTabBarContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            topTabBarContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topTabBarContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topTabBarContainer.heightAnchor.constraint(equalToConstant: view.frame.height * (Double(120)/Double(1624)))
        ])
    }
    
    func setTopTabBarConstraint() {
        NSLayoutConstraint.activate([
            topTabBarMenu.topAnchor.constraint(equalTo: topTabBarContainer.topAnchor),
            topTabBarMenu.leadingAnchor.constraint(equalTo: topTabBarContainer.leadingAnchor),
            topTabBarMenu.trailingAnchor.constraint(equalTo: topTabBarContainer.trailingAnchor),
            topTabBarMenu.bottomAnchor.constraint(equalTo: topTabBarContainer.bottomAnchor)
        ])
    }
    
    func setPageViewConstraint() {
        NSLayoutConstraint.activate([
            pageView.topAnchor.constraint(equalTo: topTabBarContainer.bottomAnchor),
            pageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}



