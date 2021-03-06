//
//  FeatureModule.swift
//  Countries
//
//  Created by Amir Ardalani on 2/24/22.
//

import Foundation

protocol FeatureModule {
    associatedtype Controller
    associatedtype Configuration

    static func makeScene(configuration: Configuration) -> Controller
}
