//
//  SplashRouterSpy.swift
//  MarvelTests
//
//  Created by Ali Hasanoğlu on 25.09.2021.
//

@testable import Marvel
import XCTest

final class SplashRouterSpy: SplashRoutingLogic, SplashDataPassing {
    var dataStore: SplashDataStore?
    var routoCharacterListCalled = false
    func routeToCharacterList() {
        routoCharacterListCalled = true
    }
}
