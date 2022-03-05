//
//  NewsListRouter.swift
//  ChopeNews
//
//  Created by ardalan on 3/5/22.
//

import Foundation
import UIKit

protocol NewsListRouting: Router {}

final class NewsListRouter: NewsListRouting {
    weak var viewController: UIViewController?
}
