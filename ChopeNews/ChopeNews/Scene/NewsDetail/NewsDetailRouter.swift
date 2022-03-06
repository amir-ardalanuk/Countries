//
//  NewsDetailRouter.swift
//  ChopeNews
//
//  Created by ardalan on 3/6/22.
//

import Foundation
import Combine
import UIKit

protocol NewsDetailRouting: Router {}

final class NewsDetailRouter: NewsDetailRouting {
    weak var viewController: UIViewController?
}
