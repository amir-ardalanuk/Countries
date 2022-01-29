import Foundation

public protocol HTTPClient {
    func request(_ request: URLRequest, result: @escaping (Data, HTTPURLResponse) -> Void )
}
