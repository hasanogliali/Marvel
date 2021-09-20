//
//  CharacterListViewController.swift
//  Marvel
//
//  Created by Ali Hasanoğlu on 19.09.2021.
//

import UIKit

protocol CharacterListDisplayLogic: AnyObject {
    
}

final class CharacterListViewController: UIViewController {
    
    var interactor: CharacterListBusinessLogic?
    var router: (CharacterListRoutingLogic & CharacterListDataPassing)?
    
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
        let interactor = CharacterListInteractor(worker: CharacterListWorker())
        let presenter = CharacterListPresenter()
        let router = CharacterListRouter()
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

extension CharacterListViewController: CharacterListDisplayLogic {
    
}
