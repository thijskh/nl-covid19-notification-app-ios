/*
 * Copyright (c) 2020 De Staat der Nederlanden, Ministerie van Volksgezondheid, Welzijn en Sport.
 *  Licensed under the EUROPEAN UNION PUBLIC LICENCE v. 1.2
 *
 *  SPDX-License-Identifier: EUPL-1.2
 */

@testable import ENCore
import Foundation
import SnapshotTesting
import XCTest

final class InfectedViewControllerTests: XCTestCase {
    private var viewController: InfectedViewController!
    private let router = InfectedRoutingMock()

    override func setUp() {
        super.setUp()

        SnapshotTesting.record = false

        let theme = ENTheme()

        viewController = InfectedViewController(theme: theme)
        viewController.router = router
    }

    // MARK: - Tests

    func testSnapshotStateLoading() {
        viewController.state = .loading
        assertSnapshot(matching: viewController, as: .image())
    }

    func testSnapshotStateSuccess() {
        viewController.state = .success
        assertSnapshot(matching: viewController, as: .image())
    }

    func testSnapshotStateError() {
        viewController.state = .error
        assertSnapshot(matching: viewController, as: .image())
    }
}
