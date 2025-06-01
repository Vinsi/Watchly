//
//  DebouncerTests.swift
//  Watchly
//
//  Created by Vinsi on 01/06/2025.
//
import TMDBCore
@testable import Watchly
import XCTest

final class DebouncerTests: XCTestCase {

    func testDebouncer_ExecutesTaskAfterDelay() async {
        let debouncer = AsyncDebouncer<String, [String]>(delay: 0.5)
        debouncer.config(operation: { _ in
            ["cat"]
        })
        debouncer.config { _ in
        }
        let expectation = XCTestExpectation(description: "Debounced task executed")

        debouncer.debounce(input: "c") { _ in
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 1.0) // Wait for execution
    }

    func testDebouncer_IgnoresDuplicateInput() async {
        let debouncer = AsyncDebouncer<String, [String]>(delay: 0.5)
        let expectation = XCTestExpectation(description: "Task should execute only once")
        expectation.expectedFulfillmentCount = 1 // Ensure it's only called once
        var count = 0
        debouncer.config(operation: { _ in
            count += 1
            return ["cat"]
        })

        debouncer.debounce(input: "c") { _ in
            expectation.fulfill()
        }

        // Schedule the same input again before the delay finishes
        debouncer.debounce(input: "c") { _ in
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 1.0) // Ensure task runs only once
    }

    func testDebouncer_CancelsPreviousTask() async {
        let debouncer = AsyncDebouncer<String, [String]>(delay: 0.5)
        let expectation = XCTestExpectation(description: "Only the last task should execute")
        expectation.expectedFulfillmentCount = 1 // Only last call should run

        debouncer.config(operation: { _ in
            ["cat"]
        })

        debouncer.debounce(input: "c") { _ in expectation.fulfill() }

        // Schedule another task before the first one executes
        debouncer.debounce(input: "ca") { _ in expectation.fulfill() }

        await fulfillment(of: [expectation], timeout: 2.0) // Ensure only one execution
    }

    func testDebouncer_ForStale_Response() async {
        let debouncer = AsyncDebouncer<String, [String]>(delay: 0.4)
        let expectation = XCTestExpectation(description: "Each unique input should trigger execution")
        expectation.expectedFulfillmentCount = 1 // Both "one" and "two" should execute

        debouncer.config(operation: {
            if $0 == "ca" {
                try? await Task.sleep(nanoseconds: 650_000_000)
                return ["kat", "cat"]
            } else {
                try? await Task.sleep(nanoseconds: 150_000_000)
                return ["cat"]
            }
        })

        debouncer.debounce(input: "ca") { _ in

            expectation.fulfill()
        }
        try? await Task.sleep(nanoseconds: 500_000_000)

        debouncer.debounce(input: "cat") { _ in

            expectation.fulfill()
        } // Different input should execute

        await fulfillment(of: [expectation], timeout: 8.5) // Ensure both executions happen
    }
}
