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
                it("user click On Add button route to open country") {
                    var value: HomeRouteAction?
                    
                    sut.routeAction.sink { action in
                        value = action
                    }.store(in: &cancellables)
                    
                    let action: HomeRouteAction = .openCountryList(config)
                    sut.handel(action: .openCountryList)
                    expect(value).toEventually(equal(action))
                }
                
                it("when updating list state should updated with new coutties") {
                    let mockCountry: Country = .stub(id: "TEST")
                    sut.routeAction.sink { action in
                        switch action {
                        case let .openCountryList(config):
                            config.updatedList([mockCountry])
                        }
                    }.store(in: &cancellables)
                    sut.handel(action: .openCountryList)
                    expect(sut.state.value.selectedCountry.map { $0.country} ).toEventually(equal([mockCountry]))
                }
            }
            
            
        }
    }
}
