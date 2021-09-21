//
//  CharacterListViewController.swift
//  Marvel
//
//  Created by Ali Hasanoğlu on 19.09.2021.
//

import UIKit

protocol CharacterListDisplayLogic: AnyObject {
    func displayCharacters(viewModel: CharacterList.FetchCharacters.ViewModel)
}

final class CharacterListViewController: UIViewController {
    
    var interactor: CharacterListBusinessLogic?
    var router: (CharacterListRoutingLogic & CharacterListDataPassing)?
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: CharacterList.FetchCharacters.ViewModel?
    @IBOutlet weak var searchBar: UISearchBar!
    
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
        collectionView.registerNib(VerticalCharacterCell.self, bundle: .main)
        collectionView.registerNib(GridCharacterCell.self, bundle: .main)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func verticalList(_ sender: Any) {
        self.viewModel?.listType = .vertical
        self.collectionView.reloadData()
    }
    
    @IBAction func gridList(_ sender: Any) {
        self.viewModel?.listType = .grid
        self.collectionView.reloadData()
    }
}

extension CharacterListViewController: CharacterListDisplayLogic {
    func displayCharacters(viewModel: CharacterList.FetchCharacters.ViewModel) {
        self.viewModel = viewModel
        collectionView.reloadData()
    }
}

extension CharacterListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.characters.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self.viewModel?.listType {
        case .vertical:
            let cell = collectionView.dequeueCell(type: VerticalCharacterCell.self, indexPath: indexPath)
            cell.configureCell(with: viewModel?.characters[indexPath.row])
            return cell
        case .grid:
            let cell = collectionView.dequeueCell(type: GridCharacterCell.self, indexPath: indexPath)
            cell.configureCell(with: viewModel?.characters[indexPath.row])
            return cell
        default: return UICollectionViewCell()
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        switch self.viewModel?.listType {
        case .vertical:
            return CGSize(width: UIScreen.main.bounds.width, height: 140)
        case .grid:
            return CGSize(width: (UIScreen.main.bounds.width - 72) / 2, height: 220)
        default:
            return .zero
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        switch self.viewModel?.listType {
        case .grid:
            return 32
        default:
            return 0
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        24
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        switch self.viewModel?.listType {
        case .vertical:
            return UIEdgeInsets(top: 24, left: 0, bottom: 24, right: 0)
        case .grid:
            return UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
        default:
            return .zero
        }
    }
}

extension CharacterListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        interactor?.fetchSearch(request: .init(searchText: searchText))
    }
}
