//
//  Loadable.swift
//  ChopeNews
//
//  Created by ardalan on 3/5/22.
//

import Foundation
import Combine

protocol LoadableProtocol {
    associatedtype DataType
    associatedtype Failure
    
    var value: DataType? { get }
    var error: Failure? { get }
    var isLoading: Bool { get }
    
}

public enum Loadable<T>: LoadableProtocol {
    
    case notRequested
    case isLoading(last: T?)
    case loaded(T)
    case failed(Error)
    
    public var value: T? {
        switch self {
        case let .loaded(value): return value
        case let .isLoading(last): return last
        default: return nil
        }
    }
    
    public var error: Error? {
        switch self {
        case let .failed(error): return error
        default: return nil
        }
    }
    
    public  var isLoading: Bool {
        switch self {
        case  .isLoading: return true
        default: return false
        }
    }
    
}

extension Publisher where Output: LoadableProtocol, Failure == Never {
    var loaded: AnyPublisher<Output.DataType, Failure> {
        self.compactMap(\.value).receive(on: DispatchQueue.main).eraseToAnyPublisher()
    }
    var isLoading: AnyPublisher<Bool, Never> {
        self.map(\.isLoading).receive(on: DispatchQueue.main).eraseToAnyPublisher()
    }
    
    var isFailed: AnyPublisher<Output.Failure, Never> {
        self.compactMap(\.error).receive(on: DispatchQueue.main).eraseToAnyPublisher()
    }
}
