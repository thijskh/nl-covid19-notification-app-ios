/*
 * Copyright (c) 2020 De Staat der Nederlanden, Ministerie van Volksgezondheid, Welzijn en Sport.
 *  Licensed under the EUROPEAN UNION PUBLIC LICENCE v. 1.2
 *
 *  SPDX-License-Identifier: EUPL-1.2
 */

import BackgroundTasks
import ENFoundation
import Foundation
import UIKit

@available(iOS 13.5,*)
@objc public final class ENAppRoot: NSObject, Logging {
    private static var version: String {
        let dictionary = Bundle.main.infoDictionary
        let version = dictionary?["CFBundleShortVersionString"] as? String ?? "n/a"
        let build = dictionary?["CFBundleVersion"] as? String ?? "n/a"

        return "OS: \(UIDevice.current.systemVersion) App: \(version)-(\(build))"
    }

    private let rootBuilder = RootBuilder()
    private var appEntryPoint: AppEntryPoint?

    @objc
    public func attach(toWindow window: UIWindow) {
        logDebug("`attach` \(ENAppRoot.version)")
        guard appEntryPoint == nil else {
            return
        }

        let appEntryPoint = rootBuilder.build()
        self.appEntryPoint = appEntryPoint

        window.rootViewController = appEntryPoint.uiviewController
    }

    @objc
    public func start() {
        logDebug("`start` \(ENAppRoot.version)")
        appEntryPoint?.start()
    }

    @objc
    public func receiveRemoteNotification(response: UNNotificationResponse) {
        logDebug("`receiveRemoteNotification` \(ENAppRoot.version)")
        appEntryPoint?.mutablePushNotificationStream.update(response: response)
    }

    @objc
    public func didBecomeActive() {
        logDebug("`didBecomeActive` \(ENAppRoot.version)")
        appEntryPoint?.didBecomeActive()
    }

    @objc
    public func didEnterForeground() {
        logDebug("`didEnterForeground` \(ENAppRoot.version)")
        appEntryPoint?.didEnterForeground()
    }

    @objc
    public func didEnterBackground() {
        logDebug("`didEnterBackground` \(ENAppRoot.version)")
        appEntryPoint?.didEnterBackground()
    }

    @objc
    public func handle(backgroundTask: BGTask) {
        logDebug("`handle` \(ENAppRoot.version)")
        appEntryPoint?.handle(backgroundTask: backgroundTask)
    }
}
