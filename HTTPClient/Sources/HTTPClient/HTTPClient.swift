import Foundation

public protocol HTTPClient {
    func request(_ request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void )
}
