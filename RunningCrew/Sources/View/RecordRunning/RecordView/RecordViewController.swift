//
//  RecordViewController.swift
//  RunningCrew
//
//  Created by JunHwan Kim on 2023/03/01.
//

import UIKit
import RxSwift

protocol RecordViewControllerDelegate: AnyObject {
    func showSaveRunningRecordView(runningRecord: RunningRecord)
}

final class RecordViewController: BaseViewController {
    
    @IBOutlet weak var runningMeasuringView: UIView!
    @IBOutlet weak var readyDiscussionLabel: UILabel!
    @IBOutlet weak var readyTimerLabel: UILabel!
    @IBOutlet weak var pauseAndPlayButton: UIButton!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var completeButtonContainerView: UIView!
    @IBOutlet weak var runningTimerLabel: UILabel!
    @IBOutlet weak var runningDistanceLabel: UILabel!
    private var completeButtonRingLayer: CAShapeLayer?
    
    weak var coordinator: RecordViewControllerDelegate?
    private var viewModel: RecordViewModel
    
    init(viewModel: RecordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
  
    override func bind() {
        let input = RecordViewModel.Input(
            pauseAndPlayButtonDidTap: pauseAndPlayButton.rx.tap.asObservable(),
            completeButtonDidTap: completeButton.rx.controlEvent(.touchDown)
                .flatMapLatest { _ -> Observable<Int> in
                    return Observable<Int>.timer(.seconds(2), scheduler: ConcurrentMainScheduler.instance)
                        .take(until: self.completeButton.rx.controlEvent([.touchUpInside, .touchUpOutside]))
                }
        )
        let output = viewModel.transform(input: input)
        
        output.startCount
            .subscribe(onNext: { [weak self] value in
                self?.readyTimerLabel.text = String(4-value)
            }, onDisposed: { [weak self] in
                self?.readyDiscussionLabel.isHidden = true
                self?.readyTimerLabel.isHidden = true
                self?.runningMeasuringView.isHidden = false
            })
            .disposed(by: disposeBag)

        output.isRunning
            .bind { [weak self] isRunning in
                let imageName = isRunning ? "pause.fill" : "play.fill"
                self?.pauseAndPlayButton.setImage(UIImage(systemName: imageName), for: .normal)
            }
            .disposed(by: disposeBag)
        
        output.runningMilliSecond
            .map { Int($0) }
            .map { totalMilliSecond in
                let second = String(format: "%02d", (totalMilliSecond / 1000) % 60)
                let minute = String(format: "%02d", ((totalMilliSecond / 1000) % 3600) / 60)
                let hour = String(format: "%02d", (totalMilliSecond / 1000) / 3600)
                
                return hour + ":" + minute + ":" + second
            }
            .bind(to: runningTimerLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.runningDistance
            .map { String(format: "%05.2f", $0) }
            .bind(to: runningDistanceLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.runningData
            .subscribe { [weak self] record in
                self?.coordinator?.showSaveRunningRecordView(runningRecord: record)
            }
            .disposed(by: disposeBag)
        
        completeButton.rx.controlEvent(.touchDown)
            .subscribe(onNext: { [weak self] in
                self?.completeButtonDidTouchTown()
            })
            .disposed(by: disposeBag)
        
        completeButton.rx.controlEvent([.touchUpInside, .touchUpOutside])
            .bind { [weak self] _ in
                self?.completeButtonRingLayer?.removeAllAnimations()
                self?.view.showToast(message: "기록을 중지하시려면 정지버튼을\n2초 이상 누르세요", position: .bottom)
            }
            .disposed(by: disposeBag)
    }
}

extension RecordViewController {
    private func completeButtonDidTouchTown() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 2
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        self.completeButtonRingLayer?.add(animation, forKey: "animation")
    }
    
    private func setView() {
        pauseAndPlayButton.layer.cornerRadius = pauseAndPlayButton.frame.height / 2
        completeButton.layer.cornerRadius = completeButton.frame.height / 2
        
        let trackLayer = CAShapeLayer()
        trackLayer.frame = completeButton.bounds
        
        completeButtonRingLayer = CAShapeLayer()
        guard let completeButtonRingLayer = completeButtonRingLayer else { return }
        completeButtonContainerView.layer.addSublayer(completeButtonRingLayer)
        
        completeButtonRingLayer.strokeColor = UIColor.black.cgColor
        completeButtonRingLayer.lineWidth = 4
        completeButtonRingLayer.fillColor = UIColor.clear.cgColor
        completeButtonRingLayer.strokeEnd = 0
        completeButtonRingLayer.path = UIBezierPath(arcCenter: trackLayer.position,
                                                    radius: completeButton.frame.width/2+2,
                                                    startAngle: .pi * (3/2),
                                                    endAngle: .pi * (7/2),
                                                    clockwise: true).cgPath
    }
}
