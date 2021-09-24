//
//  CharacterDetailViewController.swift
//  Marvel
//
//  Created by Ali Hasanoğlu on 22.09.2021.
//

import UIKit

protocol CharacterDetailDisplayLogic: AnyObject {
    func displayCharacterDetail(viewModel: CharacterDetail.FetchDetail.ViewModel)
}

final class CharacterDetailViewController: UIViewController {
    
    var interactor: CharacterDetailBusinessLogic?
    var router: (CharacterDetailRoutingLogic & CharacterDetailDataPassing)?
    
    @IBOutlet weak var tableView: UITableView!
    
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
        let interactor = CharacterDetailInteractor(worker: CharacterDetailWorker())
        let presenter = CharacterDetailPresenter()
        let router = CharacterDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeBackButton()
        interactor?.fetchCharacterDetail()
    }
    
    private func customizeBackButton() {
        let button = UIBarButtonItem(
            image: #imageLiteral(resourceName: "back"),
            style:  .plain,
            target: self,
            action: #selector(backButtonAction)
        )
        button.tintColor = .black
        self.navigationItem.leftBarButtonItem = button
    }
    
    @objc func backButtonAction() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CharacterDetailViewController: CharacterDetailDisplayLogic {
    func displayCharacterDetail(viewModel: CharacterDetail.FetchDetail.ViewModel) {
        self.title = viewModel.character?.name
    }
}

extension CharacterDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
