//
//  IBSVideoPlayer.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import AVFoundation



// MARK: - IBSVideoPlayer

///
///
///
@available(iOS 13.0, *)
public final class IBSVideoPlayer: NSObject {

    // MARK: - Public properties

    ///
    ///
    ///
    public weak var delegate: IBSVideoPlayerDelegate?

    ///
    ///
    ///
    public var rate: Float = 1 {
        willSet {
            guard let player = assetPlayer else { return }

            player.rate = newValue > 0 ? newValue : 0
        }
    }

    ///
    ///
    ///
    public var volume: Float = 0 {
        willSet {
            guard let player = assetPlayer else { return }

            player.volume = newValue
        }
    }



    // MARK: - Private properties

    private let videoContext: UnsafeMutableRawPointer? = nil

    private var assetPlayer: AVPlayer?

    private var playerItem: AVPlayerItem?

    private var urlAsset: AVURLAsset?

    private var videoOutput: AVPlayerItemVideoOutput?

    private var assetDuration = 0.0

    private var playerView: IBSPlayerView?

    private var autoRepeatPlay = false
    private var autoPlay = false



    // MARK: - Init

    ///
    ///
    ///
    public override init() {
        super.init()
    }

    ///
    ///
    ///
    convenience init(urlAsset: NSURL,
                     playerView: IBSPlayerView,
                     contentMode: AVLayerVideoGravity = .resize,
                     startAutoPlay: Bool = false,
                     repeatAfterEnd: Bool = false) {
        self.init()

        self.playerView = playerView

        autoPlay = startAutoPlay
        autoRepeatPlay = repeatAfterEnd

        guard
            let playerView = self.playerView,
            let playerLayer = playerView.layer as? AVPlayerLayer
        else { return }

        playerLayer.videoGravity = contentMode

        initialSetup(with: urlAsset)

        prepareToPlay()
    }



    // MARK: - Overriding parent methods

    ///
    ///
    ///
    public override func observeValue(forKeyPath keyPath: String?,
                                      of object: Any?,
                                      change: [NSKeyValueChangeKey : Any]?,
                                      context: UnsafeMutableRawPointer?) {
        guard
            context == videoContext,
            let key = keyPath
        else { return }

        if key == "status", let player = assetPlayer {
            playerDidChangeStatus(status: player.status)
        } else if key == "loadedTimeRanges", let item = playerItem {
            moviewPlayerLoadedTimeRangeDidUpdated(ranges: item.loadedTimeRanges)
        }
    }



    // MARK: - Public methods

    ///
    ///
    ///
    public func isPlaying() -> Bool {
        guard let player = assetPlayer else { return false }

        return player.rate > 0
    }

    ///
    ///
    ///
    public func play() {
        guard
            let player = assetPlayer,
            player.currentItem?.status == .readyToPlay
        else { return }

        player.play()
        player.rate = rate
    }

    ///
    ///
    ///
    public func pause() {
        guard let player = assetPlayer else { return }

        player.pause()
    }

    ///
    ///
    ///
    public func seekToPosition(seconds: Float64) {
        guard let player = assetPlayer else { return }

        pause()

        guard let timeScale = player.currentItem?.asset.duration.timescale else { return }

        player.seek(
            to: .init(
                seconds: seconds,
                preferredTimescale: timeScale
            )
        ) { [weak self] _ in
            guard let self else { return }

            self.play()
        }
    }



    // MARK: - Private functions

    private func initialSetup(with url: NSURL) {
        let options = [
            AVURLAssetPreferPreciseDurationAndTimingKey : true
        ]

        urlAsset = AVURLAsset(
            url: url as URL,
            options: options
        )
    }

    private func prepareToPlay() {
        let keys = ["tracks"]

        guard let asset = urlAsset else { return }

        asset.loadValuesAsynchronously(forKeys: keys) {
            DispatchQueue.global(qos: .userInitiated).async {
                DispatchQueue.main.async {
                    self.startLoading()
                }
            }
        }
    }

    private func startLoading() {
        guard let asset = urlAsset else { return }

        let status = asset.statusOfValue(forKey: "tracks", error: nil)

        guard status == AVKeyValueStatus.loaded else { return }

        assetDuration = CMTimeGetSeconds(asset.duration)

        let videoOutputOptions = [
            kCVPixelBufferPixelFormatTypeKey as String : Int(kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange)
        ]

        videoOutput = AVPlayerItemVideoOutput(pixelBufferAttributes: videoOutputOptions)

        playerItem = AVPlayerItem(asset: asset)

        guard let item = playerItem else { return }

        item.addObserver(
            self,
            forKeyPath: "status",
            options: .initial,
            context: videoContext
        )
        item.addObserver(
            self,
            forKeyPath: "loadedTimeRanges",
            options: [
                .new,
                .old
            ],
            context: videoContext
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(playerItemDidReachEnd),
            name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didFailedToPlayToEnd),
            name:NSNotification.Name.AVPlayerItemFailedToPlayToEndTime,
            object: nil
        )

        guard let output = videoOutput else { return }

        item.add(output)
        item.audioTimePitchAlgorithm = AVAudioTimePitchAlgorithm.varispeed

        assetPlayer = AVPlayer(playerItem: item)

        guard let player = assetPlayer else { return }

        player.rate = rate

        addPeriodicalObserver()

        guard
            let playerView = self.playerView,
            let layer = playerView.layer as? AVPlayerLayer
        else { return }

        layer.player = assetPlayer
    }

    private func addPeriodicalObserver() {
        let timeInterval = CMTimeMake(value: 1, timescale: 1)

        guard let player = assetPlayer else { return }

        player.addPeriodicTimeObserver(
            forInterval: timeInterval,
            queue: DispatchQueue.main,
            using: { [weak self] (time) in
                guard let self else { return }

                self.playerDidChangeTime(time: time)
            }
        )
    }

    private func playerDidChangeTime(time:CMTime) {
        guard let player = assetPlayer else { return }

        let timeNow = CMTimeGetSeconds(player.currentTime())
        let progress = timeNow / assetDuration

        delegate?.didUpdateProgress(with: progress, and: Double(timeNow))
    }

    private func playerDidChangeStatus(status: AVPlayer.Status) {
        switch status {
        case .unknown:
            break
        case .readyToPlay:
            guard let player = assetPlayer else { return }

            volume = player.volume

            delegate?.readyToPlay()

            if autoPlay && player.rate.isEqual(to: 0) {
                play()
            }
        case .failed:
            print("Failed to load video")
        @unknown default:
            break
        }
    }

    private func moviewPlayerLoadedTimeRangeDidUpdated(ranges:Array<NSValue>) {
        var maximum: TimeInterval = 0

        ranges.forEach { value in
            let range = value.timeRangeValue

            let currentLoadedTimeRange = CMTimeGetSeconds(range.start) + CMTimeGetSeconds(range.duration)

            if currentLoadedTimeRange > maximum {
                maximum = currentLoadedTimeRange
            }
        }

        let progress = assetDuration.isEqual(to: 0) ? 0 : Double(maximum) / assetDuration

        delegate?.downloadedProgress(with: progress)
    }

    private func cleanUp() {
        NotificationCenter.default.removeObserver(self)

        assetPlayer = nil
        playerItem = nil
        urlAsset = nil

        guard let item = playerItem else { return }

        item.removeObserver(self, forKeyPath: "status")
        item.removeObserver(self, forKeyPath: "loadedTimeRanges")
    }



    // MARK: - Event handlers

    @objc
    private func playerItemDidReachEnd() {
        delegate?.didFinishPlayItem()

        guard let player = assetPlayer else { return }



        if autoRepeatPlay {
            player.seek(to: .zero)
            play()
        }
    }

    @objc
    private func didFailedToPlayToEnd() {
        delegate?.didFailPlayToEnd()
    }



    // MARK: - Deinit

    deinit {
        cleanUp()
    }
}
