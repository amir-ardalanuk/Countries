import Foundation
import Combine

public protocol HTTPClient {
    func request(_ request: URLRequest) -> AnyPublisher<(Data, URLResponse), Error>
}
