//
//  IBSExtendedTabBarController.swift
//  IBSKit
//
//  Created by Dimka Novikov on 13.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import UIKit



// MARK: - IBSExtendedTabBarController

///
///
///
@available(iOS 13.0, *)
open class IBSExtendedTabBarController: UIViewController, IBSExtendedTabBarControllerPresentable {

    // MARK: - Public structures

    

    

    ///
    ///
    ///
    public struct TabBarOffsets {

        ///
        ///
        ///
        public struct Padding {

            ///
            ///
            ///
            var left: CGFloat

            ///
            ///
            ///
            var right: CGFloat

            ///
            ///
            ///
            var bottom: CGFloat

            ///
            ///
            ///
            init(left: CGFloat = 0,
                 right: CGFloat = 0,
                 bottom: CGFloat = 0) {
                self.left = left
                self.right = right
                self.bottom = bottom
            }
        }

        ///
        ///
        ///
        var padding: Padding

        ///
        ///
        ///
        var spacing: CGFloat

        ///
        ///
        ///
        var height: CGFloat

        ///
        ///
        ///
        init(padding: Padding = .init(),
             spacing: CGFloat = 0,
             height: CGFloat = 0) {
            self.padding = padding
            self.spacing = spacing
            self.height = height
        }
    }



    // MARK: - Public properties

    ///
    ///
    ///
    open var back: TabStyle { .init() }

    ///
    ///
    ///
    open var tabs: [TabStyle] { [] }

    ///
    ///
    ///
    open var tabBarOffsets: TabBarOffsets { .init() }

    ///
    ///
    ///
    public var tabBarStyle: TabBarStyle = .init() {
        willSet {
            tabBarOuterView.backgroundColor = newValue.color

            tabBarOuterView.layer.borderWidth = newValue.border.width
            tabBarOuterView.layer.borderColor = newValue.border.color

            tabBarOuterView.layer.shadowColor = newValue.shadow.color
            tabBarOuterView.layer.shadowOpacity = newValue.shadow.opacity
            tabBarOuterView.layer.shadowRadius = newValue.shadow.radius
            tabBarOuterView.layer.shadowOffset = newValue.shadow.offset

            switch newValue.corners.curve {
            case .continuous:
                tabBarOuterView.layer.cornerCurve = .continuous
            case .circular:
                tabBarOuterView.layer.cornerCurve = .circular
            }
            tabBarInnerView.layer.cornerCurve = tabBarOuterView.layer.cornerCurve

            backButton.layer.cornerCurve = tabBarInnerView.layer.cornerCurve
            tabsButtons.forEach { button in
                button.layer.cornerCurve = tabBarInnerView.layer.cornerCurve
            }

            tabBarOuterView.layer.cornerRadius = newValue.corners.radius
            tabBarInnerView.layer.cornerRadius = tabBarOuterView.layer.cornerRadius / 2

            backButton.layer.cornerRadius = tabBarInnerView.layer.cornerRadius
            tabsButtons.forEach { button in
                button.layer.cornerRadius = tabBarInnerView.layer.cornerRadius
            }

            guard let cornersSet = newValue.corners.set else { return }

            switch cornersSet {
            case .topLeft:
                tabBarOuterView.layer.maskedCorners = .layerMinXMinYCorner
            case .top:
                tabBarOuterView.layer.maskedCorners = [
                    .layerMinXMinYCorner,
                    .layerMaxXMinYCorner
                ]
            case .topRight:
                tabBarOuterView.layer.maskedCorners = .layerMaxXMinYCorner
            case .left:
                tabBarOuterView.layer.maskedCorners = [
                    .layerMinXMinYCorner,
                    .layerMinXMaxYCorner
                ]
            case .leftDiagonal:
                tabBarOuterView.layer.maskedCorners = [
                    .layerMinXMinYCorner,
                    .layerMaxXMaxYCorner
                ]
            case .right:
                tabBarOuterView.layer.maskedCorners = [
                    .layerMaxXMinYCorner,
                    .layerMaxXMaxYCorner
                ]
            case .rightDiagonal:
                tabBarOuterView.layer.maskedCorners = [
                    .layerMaxXMinYCorner,
                    .layerMinXMaxYCorner
                ]
            case .bottomLeft:
                tabBarOuterView.layer.maskedCorners = .layerMinXMaxYCorner
            case .bottom:
                tabBarOuterView.layer.maskedCorners = [
                    .layerMinXMaxYCorner,
                    .layerMaxXMaxYCorner
                ]
            case .bottomRight:
                tabBarOuterView.layer.maskedCorners = .layerMaxXMaxYCorner
            case .all:
                tabBarOuterView.layer.maskedCorners = [
                    .layerMinXMinYCorner,
                    .layerMaxXMinYCorner,
                    .layerMaxXMaxYCorner,
                    .layerMinXMaxYCorner
                ]
            }

            tabBarInnerView.layer.maskedCorners = tabBarOuterView.layer.maskedCorners

            backButton.layer.maskedCorners = tabBarInnerView.layer.maskedCorners
            tabsButtons.forEach { button in
                button.layer.maskedCorners = tabBarInnerView.layer.maskedCorners
            }
        }
    }

    ///
    ///
    ///
    public var controllers: [IBSStack<UIViewController>] = {
        var controllers: [IBSStack<UIViewController>] = []
//        controllers[0].push(<#T##element: IBSStack<UIViewController>.ElementType##IBSStack<UIViewController>.ElementType#>)

        return controllers
    }()



    // MARK: - Private properties

    private let tabBarOuterView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.clipsToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let tabBarInnerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self,
                         action: #selector(self.backButtonTouchDown(_:)),
                         for: .touchDown)
        button.addTarget(self,
                         action: #selector(self.backButtonTouchUpOutside(_:)),
                         for: .touchUpOutside)
        button.addTarget(self,
                         action: #selector(self.backButtonTouchUpInside(_:)),
                         for: .touchUpInside)
        button.isUserInteractionEnabled = true
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var backButtonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = back.image
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var tabsButtons: [UIButton] = {
        var buttons: [UIButton] = []
        tabs.forEach { _ in
            buttons.append(.init(type: .custom))
        }
        buttons
            .enumerated()
            .forEach { (index, button) in
                button.addTarget(nil,
                                 action: #selector(self.tabsButtonsTouchDown(_:)),
                                 for: .touchDown)
                button.addTarget(nil,
                                 action: #selector(self.tabsButtonsTouchUpOutside(_:)),
                                 for: .touchUpOutside)
                button.addTarget(nil,
                                 action: #selector(self.tabsButtonsTouchUpInside(_:)),
                                 for: .touchUpInside)
                button.tag = index
                button.isUserInteractionEnabled = true
                button.clipsToBounds = true
                button.translatesAutoresizingMaskIntoConstraints = false
            }
        return buttons
    }()

    private lazy var tabsButtonsImageViews: [UIImageView] = {
        var imageViews: [UIImageView] = []
        tabs.forEach { _ in
            imageViews.append(.init())
        }
        imageViews
            .enumerated()
            .forEach { (index, imageView) in
                imageView.image = tabs[index].image
                imageView.contentMode = .scaleAspectFit
                imageView.isUserInteractionEnabled = false
                imageView.clipsToBounds = true
                imageView.translatesAutoresizingMaskIntoConstraints = false
            }
        return imageViews
    }()

    private lazy var tabsButtonsViews: [UIView] = {
        var views: [UIView] = []
        tabs.forEach { _ in
            views.append(.init())
        }
        views.forEach { view in
            view.isUserInteractionEnabled = true
            view.clipsToBounds = true
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        return views
    }()

    private lazy var tabsButtonsHorizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: tabsButtonsViews)
        //        stackView.backgroundColor = .blue
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 30
        stackView.isUserInteractionEnabled = true
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private var hiddenStack: IBSStack<UIViewController> = .init()



    // MARK: - Init

    ///
    ///
    ///
    public override init(nibName nibNameOrNil: String?,
                         bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        setupRootView()
        setupViews()

        //        inititalBackButtonPosition()
    }

    ///
    ///
    ///
    public required init?(coder: NSCoder) {
        fatalError("\(IBSExtendedTabBarController.self) doesn't support XIB layout")
    }



    // MARK: - Public methods

    ///
    ///
    ///
    public func show(_ controller: UIViewController, _ completion: (() -> Void)? = nil) {
        //        view.addSubview(controller.view)
        view.insertSubview(controller.view, at: 1)
        addChild(controller)

        controller.didMove(toParent: self)

        hiddenStack.push(controller)

        completion?()
    }

    public func drop(_ completion: (() -> Void)? = nil) {
        guard let controller = hiddenStack.peek() else { return }

        controller.willMove(toParent: nil)
        controller.removeFromParent()
        controller.view.removeFromSuperview()

        hiddenStack.pop()

        completion?()
    }



    // MARK: - Event handlers

    @objc
    private func backButtonTouchDown(_ sender: UIButton) {
        IBSHaptic.feedback.execute(with: .soft)

        UIView.animate(withDuration: 0.1) {
            sender.transform = .init(scaleX: 0.95, y: 0.95)
            sender.backgroundColor = .init(white: 0.33, alpha: 0.3)
        }
    }

    @objc
    private func backButtonTouchUpOutside(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = .identity
            sender.backgroundColor = .clear
        }
    }

    @objc
    private func backButtonTouchUpInside(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = .identity
            sender.backgroundColor = .clear
        } completion: { _ in
            self.drop()
        }
    }

    @objc
    private func tabsButtonsTouchDown(_ sender: UIButton) {
        IBSHaptic.feedback.execute(with: .soft)

        UIView.animate(withDuration: 0.1) {
            sender.transform = .init(scaleX: 0.95, y: 0.95)
            sender.backgroundColor = .init(white: 0.33, alpha: 0.3)
        }
    }

    @objc
    private func tabsButtonsTouchUpOutside(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = .identity
            sender.backgroundColor = .clear
        }
    }

    @objc
    private func tabsButtonsTouchUpInside(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = .identity
            sender.backgroundColor = .clear
        } completion: { _ in
            // FIXME: Create routing logic
        }
    }



    // MARK: - Private functions

    private func inititalBackButtonPosition() {
        backButton.backgroundColor = .red
        backButton.transform = .init(translationX: -(tabBarInnerView.bounds.height + 20), y: 0)
        //        backButton.alpha = 0
    }
}



// MARK: - IBSDesignDrawable

extension IBSExtendedTabBarController: IBSDesignDrawable {

    // MARK: - Public methods

    ///
    ///
    ///
    open func setupViews() {
        view.insertSubview(tabBarOuterView, at: 1000)

        tabBarOuterView.addSubview(tabBarInnerView)
        tabBarInnerView.addSubview(tabsButtonsHorizontalStackView)

        tabsButtonsViews
            .enumerated()
            .forEach { (index, view) in
                view.addSubview(tabsButtons[index])
            }

        tabsButtons
            .enumerated()
            .forEach { (index, button) in
                button.addSubview(tabsButtonsImageViews[index])
            }
    }

    ///
    ///
    ///
    open func makeLayout() {
        NSLayoutConstraint.activate([
            tabBarOuterView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                     constant: tabBarOffsets.padding.left),
            tabBarOuterView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                      constant: -tabBarOffsets.padding.right),
            tabBarOuterView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                    constant: -tabBarOffsets.padding.bottom),
            tabBarOuterView.heightAnchor.constraint(equalToConstant: tabBarOffsets.height)
        ])

        NSLayoutConstraint.activate([
            tabBarInnerView.topAnchor.constraint(equalTo: tabBarOuterView.topAnchor,
                                                 constant: 10),
            tabBarInnerView.leadingAnchor.constraint(equalTo: tabBarOuterView.leadingAnchor,
                                                     constant: 10),
            tabBarInnerView.trailingAnchor.constraint(equalTo: tabBarOuterView.trailingAnchor,
                                                      constant: -10),
            tabBarInnerView.bottomAnchor.constraint(equalTo: tabBarOuterView.bottomAnchor,
                                                    constant: -10)
        ])

        NSLayoutConstraint.activate([
            tabsButtonsHorizontalStackView.topAnchor.constraint(equalTo: tabBarInnerView.topAnchor),
            tabsButtonsHorizontalStackView.leadingAnchor.constraint(equalTo: tabBarInnerView.leadingAnchor,
                                                                    constant: 20),
            tabsButtonsHorizontalStackView.trailingAnchor.constraint(equalTo: tabBarInnerView.trailingAnchor,
                                                                     constant: -20),
            tabsButtonsHorizontalStackView.bottomAnchor.constraint(equalTo: tabBarInnerView.bottomAnchor)
        ])

        tabsButtons
            .enumerated()
            .forEach { (index, button) in
                NSLayoutConstraint.activate([
                    button.centerXAnchor.constraint(equalTo: tabsButtonsViews[index].centerXAnchor),
                    button.centerYAnchor.constraint(equalTo: tabsButtonsViews[index].centerYAnchor),
                    button.widthAnchor.constraint(equalTo: tabsButtonsViews[index].heightAnchor),
                    button.heightAnchor.constraint(equalTo: button.widthAnchor,
                                                   multiplier: 1)
                ])
            }

        tabsButtonsImageViews
            .enumerated()
            .forEach { (index, imageView) in
                NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: tabsButtons[index].topAnchor,
                                                   constant: 13),
                    imageView.leadingAnchor.constraint(equalTo: tabsButtons[index].leadingAnchor,
                                                       constant: 13),
                    imageView.trailingAnchor.constraint(equalTo: tabsButtons[index].trailingAnchor,
                                                        constant: -13),
                    imageView.bottomAnchor.constraint(equalTo: tabsButtons[index].bottomAnchor,
                                                      constant: -13)
                ])
            }
    }



    // MARK: - Private functions

    func setupRootView() {
        view.backgroundColor = .white
    }
}
