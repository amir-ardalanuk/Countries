//
//  HomeViewModelTest.swift
//  CountriesTests
//
//  Created by ardalan on 4/9/22.
//

import Nimble
import Quick
import Core
@testable import Countries
import Combine

class HomeViewModelSpec: QuickSpec {
    override func spec() {
        describe("Selected countries show on first screen") {
            var sut: HomeViewModel!
            let countryList: [Country] = [.stub()]
            var cancellables: Set<AnyCancellable> = .init()
            var config: CountryListModule.Configuration!
            beforeEach {
                let usecases =  MockCountryListUsecases.init()
                cancellables = .init()
                usecases.resultProvider =  {
                    return .success(countryList)
                }
                config = .init(countryUseCase: usecases, updatedList: { _ in
                    
                }, selectedCountries: [])
                sut = HomeViewModel(config: .init(countryUseCase: usecases))
            }
            
            context("When user have not countries") {
                it("user click On Add button") {
                    sut.handel(action: .openCountryList)
                    
                    let action: HomeRouteAction = .openCountryList(config)
//                    waitUntil { done in
//                        sut.routeAction.sink { value in
//                            expect(value).to(equal(action))
//                            done()
//                        }.store(in: &cancellables)
//                    }
                }
            }
            
            
        }
    }
}
