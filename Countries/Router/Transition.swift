//
//  Transition.swift
//  Countries
//
//  Created by https://github.com/CassiusPacheco/iOS-Routing-Example/tree/part1/RoutingExample
//

import UIKit

protocol Transition: AnyObject {
    var isAnimated: Bool { get set }

    func open(_ viewController: UIViewController, from: UIViewController, completion: (() -> Void)?)
    func close(_ viewController: UIViewController, completion: (() -> Void)?)
}
