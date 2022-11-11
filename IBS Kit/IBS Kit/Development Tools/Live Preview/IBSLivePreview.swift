//
//  IBSLivePreview.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import SwiftUI



// MARK: - UIViewController extension

extension UIViewController {

    // MARK: - Private structures

    @available(iOS 15.0, *)
    private struct IBSLivePreview: UIViewControllerRepresentable {
        let viewController: UIViewController

        func makeUIViewController(context: Context) -> some UIViewController { viewController }

        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    }



    // MARK: - Public methods

    ///
    /// A method that represents a subclass of UIViewController into a view supported by SwiftUI Canvas that implements the View protocol.
    ///
    /// Example:
    ///
    ///     @available(iOS 15.0, *)
    ///     struct CustomViewController_Preview: PreviewProvider {
    ///         static var previews: some View {
    ///             CustomViewController()
    ///                 .livePreview()
    ///         }
    ///     }
    ///
    /// - Authors: Dmitry Novikov
    ///
    /// - Bug: None
    ///
    /// - Returns: A view supported by SwiftUI Canvas that implements the View protocol.
    ///
    @available(iOS 15.0, *)
    public func livePreview() -> some View {
        IBSLivePreview(viewController: self)
    }
}



// MARK: - UIView extension

extension UIView {

    // MARK: - Private structures

    @available(iOS 15.0, *)
    private struct IBSLivePreview: UIViewRepresentable {
        let view: UIView

        func makeUIView(context: Context) -> some UIView { view }

        func updateUIView(_ uiView: UIViewType, context: Context) { }
    }



    // MARK: - Public methods

    ///
    /// A method that represents a subclass of UIView into a view supported by SwiftUI Canvas that implements the View protocol.
    ///
    /// Example:
    ///
    ///     @available(iOS 15.0, *)
    ///     struct CustomView_Preview: PreviewProvider {
    ///         static var previews: some View {
    ///             CustomView()
    ///                 .livePreview()
    ///         }
    ///     }
    ///
    /// - Authors: Dmitry Novikov
    ///
    /// - Bug: None
    ///
    /// - Returns: A view supported by SwiftUI Canvas that implements the View protocol.
    ///
    @available(iOS 15.0, *)
    public func livePreview() -> some View {
        IBSLivePreview(view: self)
    }
}
