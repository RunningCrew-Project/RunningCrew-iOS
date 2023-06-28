//
//  YPImagePickerManager.swift
//  RunningCrew
//
//  Created by Kim TaeSoo on 2023/05/14.
//

import Foundation
import YPImagePicker
class YPImagePickerManager {
    var picker: YPImagePicker?

    func setPicker(vc: UIViewController) {
        var config = YPImagePickerConfiguration()
        config.screens = [.library]
        config.showsPhotoFilters = false // 필터 스킵
        config.shouldSaveNewPicturesToAlbum = false

                config.library.isSquareByDefault = false
//        config.library.skipSelectionsGallery = true
        config.library.onlySquare = true // 확대 버튼
    
        picker = YPImagePicker(configuration: config)
        
        picker?.didFinishPicking { [weak self] items, cancelled in
            guard let self = self else { return }
            // MARK: 여기에다가 크루 아이콘 이미지 셋
            picker?.dismiss(animated: true)
            
        }
        picker?.modalPresentationStyle = .overFullScreen
        vc.present(picker!, animated: true, completion: nil)
    }
}
