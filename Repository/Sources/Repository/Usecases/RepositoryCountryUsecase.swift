//
//  RepositoryCountryUsecase.swift
//  
//
//  Created by Amir Ardalani on 1/29/22.
//

import Foundation
import Core

class RepositoryCountryUsecase: CountryUsecase {
    let remoteUsecases: CountryUsecase
    
    init(remoteUsecases: CountryUsecase) {
        self.remoteUsecases = remoteUsecases
    }
    
    func fetchCountryList(completion: @escaping CountryListCompletion) {
        //FIXME: Could be added `LocalUsecases` or decide to bring data from local/cache or load from remote
        self.remoteUsecases.fetchCountryList(completion: completion)
    }
}
