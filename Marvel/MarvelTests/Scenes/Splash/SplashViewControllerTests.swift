//
//  SplashViewControllerTests.swift
//  MarvelTests
//
//  Created by Ali Hasanoğlu on 25.09.2021.
//

@testable import Marvel
@testable import API
import XCTest

class SplashViewControllerTests: XCTestCase {
    
    var viewController: SplashViewController?
    var interactor: SplashInteractor?
    var router = SplashRouterSpy()
    override func setUp() {
        
        guard let viewController = UIStoryboard(
            name: "Splash", bundle: .main
        ).instantiateViewController(identifier: "SplashViewController") as?
        SplashViewController else {
            XCTAssert(false, "View Controller not initialized")
            return
        }
        
        self.viewController = viewController
        interactor =  SplashInteractor(worker: SplashWorkerSpy())
        let presenter = SplashPresenter()
        presenter.viewController = viewController
        interactor?.presenter = presenter
        viewController.interactor = interactor
        viewController.router = router
        viewController.loadView()
    }

    func testInstances() {
        XCTAssertNotNil(viewController)
    }
    
    func testCharacter() {
        interactor?.fetchCharacters()
        XCTAssertNotNil(interactor?.characters)
    }
    
    func testRouting() {
        interactor?.fetchCharacters()
        XCTAssertTrue(router.routoCharacterListCalled)
    }
}
