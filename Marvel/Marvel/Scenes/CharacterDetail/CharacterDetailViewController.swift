//
//  CharacterDetailViewController.swift
//  Marvel
//
//  Created by Ali Hasanoğlu on 22.09.2021.
//

import UIKit
import Extensions

protocol CharacterDetailDisplayLogic: AnyObject {
    func displayCharacterDetail(viewModel: CharacterDetail.FetchDetail.ViewModel)
}

final class CharacterDetailViewController: UIViewController {
    
    var interactor: CharacterDetailBusinessLogic?
    var router: (CharacterDetailRoutingLogic & CharacterDetailDataPassing)?
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: CharacterDetail.FetchDetail.ViewModel?
    
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
        tableView.registerNib(CharacterPosterCell.self, bundle: .main)
        tableView.registerNib(CharacterInformationCell.self, bundle: .main)
        tableView.registerNib(ButtonsCell.self, bundle: .main)
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
        self.title = viewModel.name
        self.viewModel = viewModel
        tableView.reloadData()
    }
}

extension CharacterDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return CharacterDetail.Sections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch CharacterDetail.Sections(rawValue: indexPath.section) {
        case .poster:
            let cell = tableView.dequeueCell(type: CharacterPosterCell.self, indexPath: indexPath)
            cell.configureCell(with: viewModel?.image ?? "")
            return cell
        case .buttons:
            let cell = tableView.dequeueCell(type: ButtonsCell.self, indexPath: indexPath)
            cell.delegate = self
            return cell
        case .comics:
            let cell = tableView.dequeueCell(type: CharacterInformationCell.self, indexPath: indexPath)
            cell.configureCell(with: viewModel?.comics ?? [], title: "Comics")
            return cell
        case .series:
            let cell = tableView.dequeueCell(type: CharacterInformationCell.self, indexPath: indexPath)
            cell.configureCell(with: viewModel?.series ?? [], title: "Series")
            return cell
        case .stories:
            let cell = tableView.dequeueCell(type: CharacterInformationCell.self, indexPath: indexPath)
            cell.configureCell(with: viewModel?.stories ?? [], title: "Stories")
            return cell
        case .events:
            let cell = tableView.dequeueCell(type: CharacterInformationCell.self, indexPath: indexPath)
            cell.configureCell(with: viewModel?.events ?? [], title: "Events")
            return cell
        default: return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let automatic = UITableView.automaticDimension
        switch CharacterDetail.Sections(rawValue: indexPath.section) {
        case .comics:
            return (viewModel?.comics.count ?? 0) > 0 ? automatic: 0
        case .events:
            return (viewModel?.events.count ?? 0) > 0 ? automatic: 0
        case .series:
            return (viewModel?.series.count ?? 0) > 0 ? automatic: 0
        case .stories:
            return (viewModel?.stories.count ?? 0) > 0 ? automatic: 0
        default: return automatic
        }
    }
}

extension CharacterDetailViewController: ButtonsCellDelegate {
    func didTappedSaveButton() {
        print("save")
    }
    
    func didTappedFavoriteButton() {
        print("favorite")
    }
}
