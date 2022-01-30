//
//  EmptyTransition.swift
//  Countries
//
//  Created by https://github.com/CassiusPacheco/iOS-Routing-Example/tree/part1/RoutingExample
//

import UIKit

final class EmptyTransition {
    var isAnimated: Bool = true
}

extension EmptyTransition: Transition {
    // MARK: - Transition

    func open(_ viewController: UIViewController, from: UIViewController, completion: (() -> Void)?) {}
    func close(_ viewController: UIViewController, completion: (() -> Void)?) {}
}
