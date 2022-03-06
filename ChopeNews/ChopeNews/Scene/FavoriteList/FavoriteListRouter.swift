//
//  FavoriteListRouter.swift
//  ChopeNews
//
//  Created by ardalan on 3/6/22.
//

import Foundation
import UIKit

protocol FavoriteListRouting: Router {
    func openNewsDetail(configuration: NewsDetail.Configuration)
}

final class FavoriteListRouter: FavoriteListRouting {
    weak var viewController: UIViewController?
    
    func openNewsDetail(configuration: NewsDetail.Configuration) {
        let newsDetail = NewsDetailModule().makeScene(configuration: configuration)
        viewController?.navigationController?.pushViewController(newsDetail, animated: true)
    }
}
