//
import SwiftUI

//  Color+Helper.swift
//
//
//  Created by Vinsi.
//
import UIKit

extension Color {

    var toUIColor: UIColor? {
        guard let cgColor else { return nil }
        return UIColor(cgColor: cgColor)
    }
}
