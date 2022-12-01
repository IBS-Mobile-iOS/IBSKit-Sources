//
//  IBSCountdownView.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import UIKit



// MARK: - IBSCountdownView

///
///
///
@available(iOS 13.0, *)
public final class IBSCountdownView: UIView {

    // MARK: - Public properties

    ///
    ///
    ///
    public weak var delegate: IBSCountdownViewDelegate?

    ///
    ///
    ///
    public var countdownStyle: IBSTextStyle = .init() {
        willSet {
            countdownLabel.textColor = newValue.color
            countdownLabel.font = newValue.font
        }
    }

    ///
    ///
    ///
    public var captionStyle: IBSTextStyle = .init() {
        willSet {
            captionLabel.text = newValue.text
            captionLabel.textColor = newValue.color
            captionLabel.font = newValue.font
        }
    }



    // MARK: - Private properties

    private let countdownLabel: IBSIndentedLabel = {
        let label = IBSIndentedLabel()
        label.textAlignment = .center
        label.baselineAdjustment = .alignCenters
        label.minimumScaleFactor = 0.1
        label.isUserInteractionEnabled = false
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let captionLabel: IBSIndentedLabel = {
        let label = IBSIndentedLabel()
        label.textAlignment = .center
        label.baselineAdjustment = .alignCenters
        label.minimumScaleFactor = 0.1
        label.isUserInteractionEnabled = false
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                countdownLabel,
                captionLabel
            ]
        )
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        stackView.isUserInteractionEnabled = false
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private var estimatedTime: UInt16 = 0



    // MARK: - Init

    ///
    ///
    ///
    public override init(frame: CGRect) {
        super.init(frame: frame)

        setupRootView()
        setupViews()

        makeLayout()
    }

    ///
    ///
    ///
    public required init?(coder: NSCoder) {
        fatalError("\(IBSCountdownView.self) doesn't support XIB layout")
    }



    // MARK: - Public methods

    ///
    ///
    ///
    public func startTimer(with time: UInt16) {
        estimatedTime = time

        let timer = Timer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(self.handleTimer(timer:)),
            userInfo: nil,
            repeats: true
        )

        RunLoop.current.add(timer, forMode: .common)
    }



    // MARK: - Event handlers

    @objc
    private func handleTimer(timer: Timer) {
        countdownLabel.text = "\(estimatedTime)"

        if estimatedTime == 0 {
            timer.invalidate()

            IBSHaptic.feedback.execute(with: .success)

            delegate?.countdownDidFinished()
        } else {
            estimatedTime -= 1

            IBSHaptic.feedback.execute(with: .soft)
        }
    }
}



// MARK: - IBSDesignDrawable

@available(iOS 13.0, *)
extension IBSCountdownView: IBSDesignDrawable {

    // MARK: - Public methods

    func setupRootView() {
        backgroundColor = .clear
    }

    func setupViews() {
        addSubview(verticalStackView)
    }

    func makeLayout() {
        NSLayoutConstraint.activate([
            verticalStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            verticalStackView.topAnchor.constraint(equalTo: topAnchor,
                                                   constant: 20),
            verticalStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                                      constant: -20)
        ])
    }
}
