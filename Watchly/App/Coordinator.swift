//
//  Coordinator.swift
//  
//
//  Created by Vinsi.
//
import SwiftUI

protocol Coordinator {
    associatedtype Scene: View
    func start() -> Scene
}
