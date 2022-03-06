import Foundation

public enum StorageError: Error {
    case notExist
    case decoding
}

public protocol Storage {
    func save<T: Encodable>(_ data: T, forKey: String, completion: @escaping (Bool) -> Void)
    func fetch<T: Decodable>(forKey: String, completion: @escaping (Result<T, StorageError>) -> Void)
    func isAvailable(key: String) -> Bool
}
