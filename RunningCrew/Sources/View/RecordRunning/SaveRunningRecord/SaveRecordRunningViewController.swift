//
//  SaveRecordRunningViewController.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/03/08.
//

import UIKit
import NMapsMap

class SaveRecordRunningViewController: UIViewController {
    
    @IBOutlet weak var runningCommentTextField: UITextField!
    @IBOutlet weak var mapView: NMFMapView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    private let viewModel: SaveRecordViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        
        setCommentTextField()
        setMapView()
        setSaveButton()
        setImageCollectionView()
    }
    
    init(viewModel: SaveRecordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Set UI
    func setCommentTextField() {
        runningCommentTextField.delegate = self
        runningCommentTextField.layer.borderWidth = 2
        runningCommentTextField.layer.borderColor = UIColor.black.cgColor
    }
    
    func setMapView() {
        mapView.layer.borderWidth = 0.5
        mapView.layer.borderColor = UIColor.black.cgColor
        mapView.isScrollGestureEnabled = false
    }
    
    func setSaveButton() {
        saveButton.layer.cornerRadius = 10
        saveButton.clipsToBounds = true
    }
    
    //MARK: - Set CollectionView
    func setImageCollectionView() {
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        imageCollectionView.register(UINib(nibName: ImageCollectionViewCell.reusableIdentifier, bundle: nil), forCellWithReuseIdentifier: ImageCollectionViewCell.reusableIdentifier)
        imageCollectionView.register(UINib(nibName: AddImageCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: AddImageCollectionViewCell.identifier)
    }
    
    //MARK: - Action
    @IBAction func tapCloseButton(_ sender: Any) {
        showCloseViewAlert()
    }
}

extension SaveRecordRunningViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        runningCommentTextField.resignFirstResponder()
        return true
    }
}

extension SaveRecordRunningViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddImageCollectionViewCell.identifier, for: indexPath) as? AddImageCollectionViewCell else { return AddImageCollectionViewCell() }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reusableIdentifier, for: indexPath) as? ImageCollectionViewCell else { return ImageCollectionViewCell()}
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension SaveRecordRunningViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = imageCollectionView.frame.height
        return CGSize(width: height, height: height)
    }
}

extension SaveRecordRunningViewController {
    func showCloseViewAlert() {
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        let confirmAction = UIAlertAction(title: "예", style: .default) { [weak self] _ in
            self?.dismiss(animated: true)
        }
        
        showAlert(title: "러닝 기록 삭제", message: "러닝 기록을 삭제하시겠습니까?", actions: [cancelAction, confirmAction])
    }
    
    func showSaveRecordAlert() {
        
    }
}
