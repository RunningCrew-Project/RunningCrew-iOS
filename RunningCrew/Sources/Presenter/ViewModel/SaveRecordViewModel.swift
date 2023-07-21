//
//  SaveRecordViewModel.swift
//  RunningCrew
//
//  Created by 김기훈 Kim on 2023/07/15.
//

import UIKit
import Photos

final class SaveRecordViewModel {
    
    var selectedImages: [UIImage] = []
    private let photosOption: PHFetchOptions = PHFetchOptions()
    var allPhotos : PHFetchResult<PHAsset> = .init()
    let path: [(Double, Double)]
    
    init(path: [(Double, Double)]) {
        self.path = path
    }
    
    func viewDidLoad() {
        setPhotosOption()
    }
    
    private func setPhotosOption() {
        photosOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        allPhotos = PHAsset.fetchAssets(with: .image, options: photosOption)
        print(allPhotos)
    }
}

