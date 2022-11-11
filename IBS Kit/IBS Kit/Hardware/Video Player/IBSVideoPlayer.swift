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
            guard let player else { return }

            player.rate = newValue > 0 ? newValue : 0
        }
    }

    ///
    ///
    ///
    public var volume: Float = 0 {
        willSet {
            guard let player else { return }

            player.volume = newValue
        }
    }



    // MARK: - Private properties

    private var playerView: IBSPlayerView?

    private let context: UnsafeMutableRawPointer? = nil

    private var player: AVPlayer?

    private var item: AVPlayerItem?

    private var asset: AVURLAsset?

    private var output: AVPlayerItemVideoOutput?

    private var duration = 0.0

    private var repeatAfterEnd = false

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
    convenience init(for view: IBSPlayerView,
                     with url: NSURL,
                     contentMode: AVLayerVideoGravity = .resize,
                     autoPlay: Bool = false,
                     repeatAfterEnd: Bool = false) {
        self.init()

        guard
            let playerView = self.playerView,
            let playerLayer = playerView.layer as? AVPlayerLayer
        else { return }

        playerLayer.videoGravity = contentMode

        self.playerView = playerView

        self.autoPlay = autoPlay
        self.repeatAfterEnd = repeatAfterEnd

        initialSetup(with: url)

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
            context == context,
            let key = keyPath
        else { return }

        if key == "status", let player {
            playerDidChangeStatus(status: player.status)
        } else if key == "loadedTimeRanges", let item {
            moviewPlayerLoadedTimeRangeDidUpdated(ranges: item.loadedTimeRanges)
        }
    }



    // MARK: - Public methods

    ///
    ///
    ///
    public func isPlaying() -> Bool {
        guard let player else { return false }

        return player.rate > 0
    }

    ///
    ///
    ///
    public func play() {
        guard
            let player,
            player.currentItem?.status == .readyToPlay
        else { return }

        player.play()
        player.rate = rate
    }

    ///
    ///
    ///
    public func pause() {
        guard let player else { return }

        player.pause()
    }

    ///
    ///
    ///
    public func seekToPosition(seconds: Float64) {
        guard let player else { return }

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

        asset = AVURLAsset(
            url: url as URL,
            options: options
        )
    }

    private func prepareToPlay() {
        let keys = ["tracks"]

        guard let asset else { return }

        asset.loadValuesAsynchronously(forKeys: keys) {
            DispatchQueue.global(qos: .userInitiated).async {
                DispatchQueue.main.async {
                    self.startLoading()
                }
            }
        }
    }

    private func startLoading() {
        guard let asset else { return }

        let status = asset.statusOfValue(forKey: "tracks", error: nil)

        guard status == AVKeyValueStatus.loaded else { return }

        duration = CMTimeGetSeconds(asset.duration)

        let videoOutputOptions = [
            kCVPixelBufferPixelFormatTypeKey as String : Int(kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange)
        ]

        output = AVPlayerItemVideoOutput(pixelBufferAttributes: videoOutputOptions)

        item = .init(asset: asset)

        guard let item else { return }

        item.addObserver(
            self,
            forKeyPath: "status",
            options: .initial,
            context: context
        )

        item.addObserver(
            self,
            forKeyPath: "loadedTimeRanges",
            options: [
                .new,
                .old
            ],
            context: context
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

        guard let output else { return }

        item.add(output)
        item.audioTimePitchAlgorithm = AVAudioTimePitchAlgorithm.varispeed

        player = .init(playerItem: item)

        guard let player else { return }

        player.rate = rate

        addPeriodicalObserver()

        guard
            let playerView = self.playerView,
            let layer = playerView.layer as? AVPlayerLayer
        else { return }

        layer.player = player
    }

    private func addPeriodicalObserver() {
        let timeInterval = CMTimeMake(value: 1, timescale: 1)

        guard let player else { return }

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
        guard let player else { return }

        let timeNow = CMTimeGetSeconds(player.currentTime())
        let progress = timeNow / duration

        delegate?.didUpdateProgress(with: progress, and: Double(timeNow))
    }

    private func playerDidChangeStatus(status: AVPlayer.Status) {
        switch status {
        case .unknown:
            break
        case .readyToPlay:
            guard let player else { return }

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

        let progress = duration.isEqual(to: 0) ? 0 : Double(maximum) / duration

        delegate?.downloadedProgress(with: progress)
    }

    private func clear() {
        NotificationCenter.default.removeObserver(self)

        player = nil
        item = nil
        asset = nil

        guard let item else { return }

        item.removeObserver(self, forKeyPath: "status")
        item.removeObserver(self, forKeyPath: "loadedTimeRanges")
    }



    // MARK: - Event handlers

    @objc
    private func playerItemDidReachEnd() {
        delegate?.didFinishPlayItem()

        guard let player else { return }

        if repeatAfterEnd {
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
        clear()
    }
}
