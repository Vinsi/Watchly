//
//  WatchlyUITests.swift
//  WatchlyUITests
//
//  Created by Vinsi on 28/05/2025.
//

import XCTest

final class WatchlyUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = true
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testTapFirstItemNavigatesToDetail() {
        // Wait for the list to appear
        let app = XCUIApplication()
        app.launch()
        let firstCell = app.collectionViews.cells.element(boundBy: 0)

        XCTAssertTrue(firstCell.waitForExistence(timeout: 5), "First cell did not appear")

        // Tap the first item
        firstCell.tap()

        // Wait for the detail view to appear (e.g., title label or image)
        let detailLabel = app.staticTexts["detail_title"] // Accessibility identifier set in SwiftUI/UIView
        XCTAssertTrue(detailLabel.waitForExistence(timeout: 5), "Detail view did not appear")
    }

//    @MainActor
//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
