//
//  SplashViewController.swift
//  Marvel
//
//  Created by Ali Hasanoğlu on 20.09.2021.
//

import UIKit

protocol SplashDisplayLogic: AnyObject {
    func displayCharacters()
    func displayError(_ message: String)
}

final class SplashViewController: UIViewController {
    
    var interactor: SplashBusinessLogic?
    var router: (SplashRoutingLogic & SplashDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = SplashInteractor(worker: SplashWorker())
        let presenter = SplashPresenter()
        let router = SplashRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchCharacters()
    }
}

extension SplashViewController: SplashDisplayLogic {
    func displayCharacters() {
        router?.routeToCharacterList()
    }
    
    func displayError(_ message: String) {
        presentAlert(message)
    }
}
