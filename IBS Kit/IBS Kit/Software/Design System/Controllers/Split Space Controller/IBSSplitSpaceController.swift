//
//  IBSSplitSpaceController.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 12.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import UIKit



// MARK: - IBSSplitSpaceController

///
/// A class that implements the operation of the Split Space Controller and all of its properties.
///
@available(iOS 13.0, *)
open class IBSSplitSpaceController: UIViewController, IBSSplitSpaceControllerPresentable {

    // MARK: - Public properties

    ///
    /// A property that allows you to set the minimum size of the left side.
    ///
    open var minimumLeftSideSize: CGFloat { 50.0 }

    ///
    /// A property that allows you to set the maximum size of the left side.
    ///
    open var maximumLeftSideSize: CGFloat { 200.0 }

    ///
    /// A property that allows you to set the initial state of the left side.
    ///
    open var leftSideInitialState: LeftSideInitialState { .fold }

    ///
    /// A property that allows you to set the supported states by the left side.
    ///
    open var leftSideSupportedState: LeftSideSupportedState { .all }

    ///
    /// A property that allows you to specify a custom ViewController as the left side.
    ///
    open var leftSideViewController: UIViewController = .init()

    ///
    /// A property that allows you to specify a custom ViewController as the right side.
    ///
    open var rightSideViewController: UIViewController = .init()

    ///
    /// A property that allows you to get information about whether the left side is currently collapsed or expanded.
    ///
    public lazy var isLeftSideCollapsed: Bool = {
        switch leftSideInitialState {
        case .fold:
            return true
        case .unfold:
            return false
        }
    }()



    // MARK: - Private properties

    private var leftSideWidth: CGFloat {
        switch leftSideSupportedState {
        case .all:
            return isLeftSideCollapsed ? minimumLeftSideSize : maximumLeftSideSize
        case .fold:
            return minimumLeftSideSize
        case .unfold:
            return maximumLeftSideSize
        }
    }



    // MARK: - Overriding parent methods

    ///
    /// Called after the controller's view is loaded into memory.
    ///
    /// - authors: Dmitry Novikov
    ///
    /// - bug: None
    ///
    open override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()

        makeLayout()
    }



    // MARK: - Public methods

    ///
    /// A method that implements folding and unfolding of the left side with the given parameters.
    ///
    /// The method can also be overridden by an inherited class in case a custom implementation of handling the folding and unfolding of the left and right sides is needed.
    ///
    /// - parameters:
    ///    - animated: Allows you to specify the presence of animation when folding and unfolding the left side. The value `true` is set by default.
    ///    - duration: Allows you to specify the animation time. The value `0.5` is set by default.
    ///    - options: Allows you to specify animation options. The value `.curveEaseInOut` is set by default.
    ///
    /// - authors: Dmitry Novikov
    ///
    /// - bug: None
    ///
    open func collapseLeftSide(_ animated: Bool = true,
                               with duration: TimeInterval = 0.5,
                               and options: UIView.AnimationOptions = .curveEaseInOut) {
        if animated {
            view.layoutIfNeeded()

            UIView.animate(withDuration: duration,
                           delay: .zero,
                           options: options) {
                self.leftSideViewController.view.widthAnchor.constraint(equalToConstant: self.leftSideWidth).isActive = true

                self.view.layoutIfNeeded()
            } completion: { _ in
                self.isLeftSideCollapsed.toggle()
            }
        } else {
            leftSideViewController.view.widthAnchor.constraint(equalToConstant: leftSideWidth).isActive = true

            view.layoutIfNeeded()

            isLeftSideCollapsed.toggle()
        }
    }
}



// MARK: - IBSDesignDrawable

@available(iOS 13.0, *)
extension IBSSplitSpaceController: IBSDesignDrawable {

    // MARK: - Public methods

    func setupRootView() {
        view.backgroundColor = .clear
    }

    func setupViews() {
        addChild(leftSideViewController)
        addChild(rightSideViewController)

        view.addSubview(leftSideViewController.view)
        view.addSubview(rightSideViewController.view)

        leftSideViewController.view.clipsToBounds = true
        rightSideViewController.view.clipsToBounds = true

        leftSideViewController.view.translatesAutoresizingMaskIntoConstraints = false
        rightSideViewController.view.translatesAutoresizingMaskIntoConstraints = false

        leftSideViewController.didMove(toParent: self)
        rightSideViewController.didMove(toParent: self)
    }

    func makeLayout() {
        NSLayoutConstraint.activate([
            leftSideViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            leftSideViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leftSideViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            leftSideViewController.view.widthAnchor.constraint(equalToConstant: leftSideWidth)
        ])

        NSLayoutConstraint.activate([
            rightSideViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            rightSideViewController.view.leadingAnchor.constraint(equalTo: leftSideViewController.view.trailingAnchor),
            rightSideViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rightSideViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
