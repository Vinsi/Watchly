//
//  LastNthItem.swift
//  Watchly
//
//  Created by Vinsi on 01/06/2025.
//

extension [any ListViewDataType] {
    func lastNthItem(is object: Element, nthIndex: Int) -> Bool {
        suffix(nthIndex).first?.movieID == object.movieID
    }
}
