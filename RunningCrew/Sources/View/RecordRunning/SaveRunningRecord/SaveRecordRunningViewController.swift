//
//  SaveRecordRunningViewController.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/03/08.
//

import UIKit
import NMapsMap
import RxSwift
import RxCocoa
import PhotosUI

protocol SaveRecordRunningViewControllerDelegate: AnyObject {
    func dismissView()
}

final class SaveRecordRunningViewController: BaseViewController {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var averagePace: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var calorie: UILabel!
    
    @IBOutlet weak var mapView: NMFMapView!
    
    @IBOutlet weak var imageStack: UIStackView!
    @IBOutlet weak var addImageView: UIView!
    @IBOutlet weak var plusImage: UIImageView!
    @IBOutlet weak var imageCountLabel: UILabel!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    @IBOutlet weak var contentStack: UIStackView!
    @IBOutlet weak var runningCommentTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
    private let viewModel: SaveRecordViewModel
    private let photos: BehaviorRelay<[Data]> = BehaviorRelay<[Data]>(value: [])
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    weak var coordinator: SaveRecordRunningViewControllerDelegate?
    
    enum Section {
        case image
    }
    
    struct Item: Hashable {
        let id = UUID()
        let data: Data
    }
    
    init(viewModel: SaveRecordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setView()
        setUICollectionView()
        super.viewDidLoad()
    }
    
    override func bind() {
        let input = SaveRecordViewModel.Input(
            textFieldDidChanged: runningCommentTextField.rx.text.orEmpty.asObservable(),
            photos: photos.asObservable())
        let output = viewModel.transform(input: input)
        
        output.location
            .map { NMFCameraUpdate(position: NMFCameraPosition(NMGLatLng(lat: $0.latitude, lng: $0.longitude), zoom: 14)) }
            .withUnretained(self)
            .bind { (owner, updatePosition) in
                owner.mapView.moveCamera(updatePosition)
                owner.mapView.positionMode = .direction
            }
            .disposed(by: disposeBag)
        
        output.photos
            .observe(on: MainScheduler.instance)
            .bind { data in
                let items = data.map { Item(data: $0) }
                
                var updatedSnapshot = NSDiffableDataSourceSnapshot<Section, Item>()
                updatedSnapshot.appendSections([.image])
                updatedSnapshot.appendItems(items)
                self.dataSource.apply(updatedSnapshot, animatingDifferences: true)
            }
            .disposed(by: disposeBag)
        
        if output.isLogIn {
            finishButton.isHidden = true
        } else {
            imageStack.isHidden = true
            contentStack.isHidden = true
            saveButton.isHidden = true
        }
        
        distanceLabel.text = String(format: "%05.2f", output.distance)
        
        let second = String(format: "%02d", (output.milliSeconds / 1000) % 60)
        let minute = String(format: "%02d", ((output.milliSeconds / 1000) % 3600) / 60)
        let hour = String(format: "%02d", (output.milliSeconds / 1000) / 3600)
        timeLabel.text = hour + ":" + minute + ":" + second
        
        let pathOverlay = NMFPath()
        pathOverlay.path = NMGLineString(points: output.path.map { NMGLatLng(lat: $0.0, lng: $0.1) })
        pathOverlay.mapView = mapView
        
        currentTimeLabel.text = output.date
        
        closeButton.rx.tap
            .bind { [weak self] in self?.showCloseViewAlert() }
            .disposed(by: disposeBag)
        
        plusImage.rx.tapGesture().when(.recognized)
            .bind { [weak self] _ in self?.showPHPicker() }
            .disposed(by: disposeBag)
        
        saveButton.rx.tap
            .bind { [weak self] _ in self?.showSaveRecordAlert() }
            .disposed(by: disposeBag)
        
        finishButton.rx.tap
            .bind { [weak self] _ in self?.coordinator?.dismissView() }
            .disposed(by: disposeBag)
    }
}

extension SaveRecordRunningViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        runningCommentTextField.resignFirstResponder()
        return true
    }
}

extension SaveRecordRunningViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row, indexPath.section, indexPath.item)
    }
}

extension SaveRecordRunningViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = imageCollectionView.frame.height
        return CGSize(width: height, height: height)
    }
}

extension SaveRecordRunningViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let itemProviders = results.map { $0.itemProvider }

        itemProviders.forEach { itemProvider in
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                guard let self = self else { return }
                guard let data = (image as? UIImage)?.pngData() else { return }
                
                self.photos.accept(photos.value + [data])
            }
        }
    }
}

extension SaveRecordRunningViewController {
    private func setView() {
        runningCommentTextField.delegate = self
        runningCommentTextField.layer.borderWidth = 2
        runningCommentTextField.layer.borderColor = UIColor.black.cgColor
        
        mapView.layer.borderWidth = 0.5
        mapView.layer.borderColor = UIColor.black.cgColor
        mapView.isScrollGestureEnabled = false
        
        saveButton.layer.cornerRadius = 10
        saveButton.clipsToBounds = true
        
        let path = UIBezierPath(rect: addImageView.bounds.insetBy(dx: 3, dy: 3))
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = UIColor.gray.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.lineWidth = 3
        borderLayer.lineDashPattern = [3, 3]
        borderLayer.path = path.cgPath
        addImageView.layer.addSublayer(borderLayer)
    }
    
    private func setUICollectionView() {
        imageCollectionView.delegate = self
        imageCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.reusableIdentifier)
        
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: imageCollectionView) { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reusableIdentifier, for: indexPath) as? ImageCollectionViewCell else { return ImageCollectionViewCell() }
            cell.imageView.image = UIImage(data: item.data)
            return cell
        }
    }
    
    private func showCloseViewAlert() {
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        let confirmAction = UIAlertAction(title: "예", style: .default) { [weak self] _ in
            self?.coordinator?.dismissView()
        }
        
        showAlert(title: "러닝 기록 삭제", message: "러닝 기록을 삭제하시겠습니까?", actions: [cancelAction, confirmAction])
    }
    
    private func showSaveRecordAlert() {
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        let confirmAction = UIAlertAction(title: "예", style: .default) { [weak self] _ in
            // TODO: 러닝 기록 저장
        }
        
        showAlert(title: "러닝 기록 저장", message: "러닝 기록을 저장하시겠습니까?", actions: [cancelAction, confirmAction])
    }
    
    private func showPHPicker() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 5 - photos.value.count
        configuration.filter = .any(of: [.images, .panoramas, .screenshots])
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true)
    }
}
