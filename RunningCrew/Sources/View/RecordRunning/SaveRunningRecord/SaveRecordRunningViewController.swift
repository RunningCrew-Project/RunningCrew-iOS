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
import RxGesture

protocol SaveRecordRunningViewControllerDelegate: AnyObject {
    func dismissView()
}

final class SaveRecordRunningViewController: BaseViewController {
    
    weak var coordinator: SaveRecordRunningViewControllerDelegate?
    
    private let viewModel: SaveRecordViewModel
    private var saveRecordRunningView: SaveRecordRunningView!
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, Item>!
    private let photos: BehaviorRelay<[Data]> = BehaviorRelay<[Data]>(value: [])
    private let confirmSaveRecord: PublishRelay<Void> = PublishRelay()
    
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
    
    override func loadView() {
        self.saveRecordRunningView = SaveRecordRunningView()
        self.view = saveRecordRunningView
    }
    
    override func viewDidLoad() {
        dataSource = UICollectionViewDiffableDataSource<Int, Item>(collectionView: saveRecordRunningView.imageCollectionView) { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reusableIdentifier, for: indexPath) as? ImageCollectionViewCell else { return ImageCollectionViewCell() }
            cell.imageView.image = UIImage(data: item.data)
            return cell
        }
        
        super.viewDidLoad()
    }
    
    override func bind() {
        let input = SaveRecordViewModel.Input(
            textFieldDidChanged: saveRecordRunningView.contentTextField.rx.text.orEmpty.asObservable(),
            photos: photos.asObservable(),
            confirmSaveRecord: confirmSaveRecord.asObservable())
        let output = viewModel.transform(input: input)
        
        saveRecordRunningView.currentTimeLabel.text = output.runningRecord.startDateTime
        
        saveRecordRunningView.crewNameLabel.text = output.runningRecord.runningNoticeId == nil ? "개인러닝" : "크루러닝"
        
        saveRecordRunningView.kilometerNumberLabel.text = String(format: "%05.2f", output.runningRecord.runningDistance)
        
        saveRecordRunningView.averagePaceNumberLabel.text = "\(String(format: "%.2d", output.runningRecord.runningPace / 60))\'\(String(format: "%.2d", output.runningRecord.runningPace % 60))\""
        
        let second = String(format: "%02d", output.runningRecord.runningTime % 60)
        let minute = String(format: "%02d", (output.runningRecord.runningTime % 3600) / 60)
        let hour = String(format: "%02d", output.runningRecord.runningTime / 3600)
        saveRecordRunningView.timeNumberLabel.text = hour + ":" + minute + ":" + second
        
        saveRecordRunningView.caloriesNumberLabel.text = "\(String(format: "%.4d", output.runningRecord.calories))"
        
        output.location
            .withUnretained(self)
            .bind { (owner, position) in
                let cameraUpdate = NMFCameraUpdate(position: NMFCameraPosition(NMGLatLng(lat: position.latitude, lng: position.longitude), zoom: 14))
                
                owner.saveRecordRunningView.mapView.mapView.moveCamera(cameraUpdate)
                owner.saveRecordRunningView.mapView.mapView.positionMode = .direction
            }
            .disposed(by: disposeBag)
        
        let pathOverlay = NMFPath()
        pathOverlay.path = NMGLineString(points: output.runningRecord.gps.map { NMGLatLng(lat: $0.latitude, lng: $0.longitude) })
        pathOverlay.mapView = saveRecordRunningView.mapView.mapView
        
        output.photos
            .observe(on: MainScheduler.instance)
            .bind { [weak self] data in
                let items = data.map { Item(data: $0) }
                
                var updatedSnapshot = NSDiffableDataSourceSnapshot<Int, Item>()
                updatedSnapshot.appendSections([0])
                updatedSnapshot.appendItems(items, toSection: 0)
                self?.dataSource.apply(updatedSnapshot, animatingDifferences: true)
                
                self?.saveRecordRunningView.imageCountLabel.text = "\(data.count) / 5"
            }
            .disposed(by: disposeBag)
        
        if output.isLogIn {
            saveRecordRunningView.needLogInLabel.removeFromSuperview()
            saveRecordRunningView.finishButton.removeFromSuperview()
        } else {
            saveRecordRunningView.addImageTitleLabel.removeFromSuperview()
            saveRecordRunningView.addImageView.removeFromSuperview()
            saveRecordRunningView.imageCollectionView.removeFromSuperview()
            saveRecordRunningView.contentTitleLabel.removeFromSuperview()
            saveRecordRunningView.contentTextField.removeFromSuperview()
            saveRecordRunningView.saveButton.removeFromSuperview()
        }
        
        output.isSuccessSaveRecord
            .bind { [weak self] result in
                if result {
                    self?.showSaveRecordResultAlert()
                } else {
                    self?.view.showToast(message: "기록 저장에 실패했습니다.", position: .bottom)
                }
            }
            .disposed(by: disposeBag)
        
        saveRecordRunningView.closeButton.rx.tap
            .bind { [weak self] in self?.showCloseViewAlert() }
            .disposed(by: disposeBag)
        
        saveRecordRunningView.addImageView.rx.tapGesture().when(.recognized)
            .bind { [weak self] _ in self?.showPHPicker() }
            .disposed(by: disposeBag)
        
        saveRecordRunningView.saveButton.rx.tap
            .bind { [weak self] _ in self?.showSaveRecordAlert() }
            .disposed(by: disposeBag)
        
        saveRecordRunningView.finishButton.rx.tap
            .bind { [weak self] _ in self?.coordinator?.dismissView() }
            .disposed(by: disposeBag)
    }
}

extension SaveRecordRunningViewController {
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
            self?.confirmSaveRecord.accept(())
        }
        
        showAlert(title: "러닝 기록 저장", message: "러닝 기록을 저장하시겠습니까?", actions: [cancelAction, confirmAction])
    }
    
    private func showSaveRecordResultAlert() {
        let confirmAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            self?.coordinator?.dismissView()
        }
        
        showAlert(title: "러닝 기록 저장", message: "러닝 기록 저장에 성공했습니다.", actions: [confirmAction])
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

extension SaveRecordRunningViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let itemProviders = results.map { $0.itemProvider }

        itemProviders.forEach { itemProvider in
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                guard let self = self, error == nil else { return }
                guard let data = (image as? UIImage)?.pngData() else { return }
                self.photos.accept(photos.value + [data])
            }
        }
    }
}
