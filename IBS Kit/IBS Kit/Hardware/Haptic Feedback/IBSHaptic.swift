//
//  IBSHaptic.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import UIKit
import AudioToolbox.AudioServices



// MARK: - IBSHaptic

///
/// A class that implements the operation of  Haptic Feedback.
///
@available(iOS 13.0, *)
public final class IBSHaptic: IBSHapticExecutable {

    // MARK: - Private enumerations

    private enum FeedbackSupportLevel {
        case none
        case partial
        case full
    }



    // MARK: - Static properties

    ///
    /// A shared property that allows access to the properties of a class that implements the IBSHapticExecutable protocol.
    ///
    public static let feedback: IBSHapticExecutable = IBSHaptic()



    // MARK: - Private properties

    private let feedbackSupportLevel: FeedbackSupportLevel = {
        let device = IBSDevice.current.device

        if device.type == .iPhone {
            switch device.name {
            case .iPhone_SE_1st_generation:
                return .none
            case .iPhone_6s, .iPhone_6s_Plus:
                return .partial
            default:
                return .full
            }
        }

        return .none
    }()



    // MARK: - Init

    private init() { }



    // MARK: - Public methods

    ///
    /// A method that implements haptic feedback with a given feedback type.
    ///
    /// Allows you to use the  Taptic Engine without using wrappers to reconciliate the device type, and also supports multithreading by default.
    ///
    /// To implement taptic feedback, it is enough to refer to the `execute(with: IBSHaptic.FeedbackType)` method.
    ///
    /// Example:
    ///
    ///     IBSHaptic.feedback.execute(with: .success)
    ///
    /// - Parameters:
    ///    - feedbackType: Enumeration of the types of possible haptic feedback.
    ///
    /// - Authors: Dmitry Novikov
    ///
    /// - Bug: None
    ///
    public func execute(with feedbackType: FeedbackType) {
        switch feedbackType {
        case .error:
            switch feedbackSupportLevel {
            case .none:
                break
            case .partial:
                Task(priority: .userInitiated) {
                    AudioServicesPlaySystemSound(SystemSoundID(1521))
                }
            case .full:
                let tapticEngine = UINotificationFeedbackGenerator()
                tapticEngine.prepare()

                Task(priority: .userInitiated) {
                    await tapticEngine.notificationOccurred(.error)
                }
            }
        case .warning:
            switch feedbackSupportLevel {
            case .none:
                break
            case .partial:
                Task(priority: .userInitiated) {
                    AudioServicesPlaySystemSound(SystemSoundID(1521))
                }
            case .full:
                let tapticEngine = UINotificationFeedbackGenerator()
                tapticEngine.prepare()

                Task(priority: .userInitiated) {
                    await tapticEngine.notificationOccurred(.warning)
                }
            }
        case .success:
            switch feedbackSupportLevel {
            case .none:
                break
            case .partial:
                Task(priority: .userInitiated) {
                    AudioServicesPlaySystemSound(SystemSoundID(1519))
                }
            case .full:
                let tapticEngine = UINotificationFeedbackGenerator()
                tapticEngine.prepare()

                Task(priority: .userInitiated) {
                    await tapticEngine.notificationOccurred(.success)
                }
            }
        case .soft:
            switch feedbackSupportLevel {
            case .none:
                break
            case .partial:
                Task(priority: .userInitiated) {
                    AudioServicesPlaySystemSound(SystemSoundID(1519))
                }
            case .full:
                let tapticEngine = UIImpactFeedbackGenerator(style: .soft)
                tapticEngine.prepare()

                Task(priority: .userInitiated) {
                    await tapticEngine.impactOccurred()
                }
            }
        case .light:
            switch feedbackSupportLevel {
            case .none:
                break
            case .partial:
                Task(priority: .userInitiated) {
                    AudioServicesPlaySystemSound(SystemSoundID(1519))
                }
            case .full:
                let tapticEngine = UIImpactFeedbackGenerator(style: .light)
                tapticEngine.prepare()

                Task(priority: .userInitiated) {
                    await tapticEngine.impactOccurred()
                }
            }
        case .medium:
            switch feedbackSupportLevel {
            case .none:
                break
            case .partial:
                Task(priority: .userInitiated) {
                    AudioServicesPlaySystemSound(SystemSoundID(1520))
                }
            case .full:
                let tapticEngine = UIImpactFeedbackGenerator(style: .medium)
                tapticEngine.prepare()

                Task(priority: .userInitiated) {
                    await tapticEngine.impactOccurred()
                }
            }
        case .heavy:
            switch feedbackSupportLevel {
            case .none:
                break
            case .partial:
                Task(priority: .userInitiated) {
                    AudioServicesPlaySystemSound(SystemSoundID(1520))
                }
            case .full:
                let tapticEngine = UIImpactFeedbackGenerator(style: .heavy)
                tapticEngine.prepare()

                Task(priority: .userInitiated) {
                    await tapticEngine.impactOccurred()
                }
            }
        case .rigid:
            switch feedbackSupportLevel {
            case .none:
                break
            case .partial:
                Task(priority: .userInitiated) {
                    AudioServicesPlaySystemSound(SystemSoundID(1520))
                }
            case .full:
                let tapticEngine = UIImpactFeedbackGenerator(style: .rigid)
                tapticEngine.prepare()

                Task(priority: .userInitiated) {
                    await tapticEngine.impactOccurred()
                }
            }
        case .selection:
            switch feedbackSupportLevel {
            case .none:
                break
            case .partial:
                Task(priority: .userInitiated) {
                    AudioServicesPlaySystemSound(SystemSoundID(1519))
                }
            case .full:
                let tapticEngine = UISelectionFeedbackGenerator()
                tapticEngine.prepare()

                Task(priority: .userInitiated) {
                    await tapticEngine.selectionChanged()
                }
            }
        }
    }
}
