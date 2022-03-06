//
//  NewsListRouter.swift
//  ChopeNews
//
//  Created by ardalan on 3/5/22.
//

import Foundation
import UIKit

protocol NewsListRouting: Router {
    func openNewsDetail(configuration: NewsDetail.Configuration)
}

final class NewsListRouter: NewsListRouting {
    weak var viewController: UIViewController?
    
    func openNewsDetail(configuration: NewsDetail.Configuration) {
        let newsDetail = NewsDetailModule().makeScene(configuration: configuration)
        viewController?.navigationController?.pushViewController(newsDetail, animated: true)
    }
}
