//
//  IBSPlayerView.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import UIKit
import AVFoundation



// MARK: - IBSPlayerView

///
///
///
@available(iOS 13.0, *)
public final class IBSPlayerView: UIView {

    // MARK: - Public properties

    ///
    ///
    ///
    public var player: AVPlayer? {
        get { playerLayer.player }
        set { playerLayer.player = newValue }
    }

    ///
    ///
    ///
    public override static var layerClass: AnyClass { AVPlayerLayer.self }



    // MARK: - Private properties

    private var playerLayer: AVPlayerLayer { layer as! AVPlayerLayer }
}



// MARK: - IBSDesignDrawable

extension IBSPlayerView: IBSDesignDrawable {

    // MARK: - Public methods

    ///
    ///
    ///
    func setupViews() { }
}
