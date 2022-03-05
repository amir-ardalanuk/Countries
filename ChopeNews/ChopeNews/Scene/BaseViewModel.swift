//
//  BaseViewModel.swift
//  ChopeNews
//
//  Created by ardalan on 3/5/22.
//

import Foundation
import Combine

protocol BaseViewModel: AnyObject {
    var cancellables: Set<AnyCancellable> { get set }
}
