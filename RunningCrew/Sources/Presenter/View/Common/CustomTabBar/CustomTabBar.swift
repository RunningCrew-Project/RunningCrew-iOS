//
//  CustomTabBar.swift
//  RunningCrew
//
//  Created by 김기훈 on 2023/07/21.
//

import UIKit
import SnapKit

struct MenuItem {
    let title: String
    var isSelect: Bool
}

protocol CustomTabBarDelegate: AnyObject {
    func didSelect(indexNum: Int)
}

final class CustomTabBar: BaseView {
    
    lazy var topTabBarMenu: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 30, height: 30)
        layout.minimumLineSpacing = 0.0
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.contentInset = .zero
        
        return collectionView
    }()
    
    weak var delegate: CustomTabBarDelegate?
    private var items: [MenuItem]
    
    init(items: [MenuItem]) {
        self.items = items
        super.init(frame: .zero)
        setCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addViews() {
        addSubview(topTabBarMenu)
    }
    
    override func setConstraint() {
        topTabBarMenu.snp.makeConstraints {
            $0.top.height.leading.trailing.equalToSuperview()
        }
    }
    
    private func setCollectionView() {
        topTabBarMenu.register(MenuBarCell.self, forCellWithReuseIdentifier: MenuBarCell.reusableIdentifier)
        topTabBarMenu.dataSource = self
        topTabBarMenu.delegate = self
        topTabBarMenu.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: [])
    }
}

extension CustomTabBar: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuBarCell.reusableIdentifier, for: indexPath) as? MenuBarCell else { return MenuBarCell() }
        cell.itemTitle.text = "\(items[indexPath.row].title)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        cell.isSelected = true
        
        delegate?.didSelect(indexNum: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        cell.isSelected = false
    }
}

extension CustomTabBar: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        return CGSize(width: width/CGFloat(items.count), height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
