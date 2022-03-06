//
//  File.swift
//  
//
//  Created by ardalan on 3/6/22.
//

import Foundation

class UserDefaultHelper: Storage {
    let useDefault: UserDefaults
    
    init(useDefault: UserDefaults) {
        self.useDefault = useDefault
    }
    
    func save<T>(_ data: T, forKey key: String, completion: @escaping (Bool) -> Void) where T : Encodable {
        do {
            let encoded = try JSONEncoder().encode(data)
            useDefault.setValue(encoded, forKey: key)
            completion(true)
        } catch {
            completion(false)
        }
    }
    
    func fetch<T>(forKey key: String, completion: @escaping (Result<T, StorageError>) -> Void) where T : Decodable {
        if let data = self.useDefault.data(forKey: key) {
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decoding))
            }
        } else {
            completion(.failure(.notExist))
        }
    }
    
    func isAvailable(key: String) -> Bool {
        return useDefault.data(forKey: key) != nil
    }
    
}
