//
//  TrendingMovies.swift
//  WatchlyUITests
//
//  Created by Vinsi on 01/06/2025.
//

import XCTest

final class TrendingMovies: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = true
    }

    func testNavigationToDetailPage() throws {

        let app = XCUIApplication()
        app.launch()
        let element = app.scrollViews.children(matching: .other).element(boundBy: 0).children(matching: .other).element
        element.children(matching: .image).element(boundBy: 3).swipeUp()
        element.children(matching: .image).element(boundBy: 7).swipeUp()
        element.children(matching: .image).element(boundBy: 10).tap()
        app.navigationBars["Movie Details"]/*@START_MENU_TOKEN@*/ .buttons["ArrowLeft"]/*[[".otherElements[\"ArrowLeft\"].buttons[\"ArrowLeft\"]",".buttons[\"ArrowLeft\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ .tap()
    }

    func testSearchPage() throws {

        let app = XCUIApplication()
        app.launch()
        let searchTabButton = app.tabBars["Tab Bar"].buttons["Search Movie"]
        XCTAssertTrue(searchTabButton.waitForExistence(timeout: 5), "Search tab button did not appear in time.")
        searchTabButton.tap()
        let searchText = app.textFields["Search movie"]
        XCTAssertTrue(searchText.waitForExistence(timeout: 5), "Search tab button did not appear in time.")
        searchText.tap()
        // Wait for keyboard to appear
        let keyboard = app.keyboards.element
        XCTAssertTrue(keyboard.waitForExistence(timeout: 5), "Keyboard did not appear in time")

        let tKey = app.keys["M"]
        tKey.tap()
        let yKey = app.keys["a"]
        yKey.tap()
        let tKey2 = app.keys["t"]
        tKey2.tap()
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".otherElements[\"UIKeyboardLayoutStar Preview\"]",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,3],[-1,2],[-1,1,2],[-1,0,1]],[[-1,3],[-1,2],[-1,1,2]],[[-1,3],[-1,2]]],[0]]@END_MENU_TOKEN@*/ .tap()

        let firstMovie = app.images.matching(identifier: "moviebox").element(boundBy: 0)

        // Wait for it to appear and tap it
        XCTAssertTrue(firstMovie.waitForExistence(timeout: 5), "First MovieBox did not appear")
        firstMovie.tap()
    }
}
