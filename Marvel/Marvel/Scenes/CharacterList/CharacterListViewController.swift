//
//  CharacterListViewController.swift
//  Marvel
//
//  Created by Ali Hasanoğlu on 19.09.2021.
//

import UIKit
import Extensions

protocol CharacterListDisplayLogic: AnyObject {
    func displayCharacters(viewModel: CharacterList.FetchCharacters.ViewModel)
    func displayError(_ message: String)
}

final class CharacterListViewController: UIViewController {
    
    var interactor: CharacterListBusinessLogic?
    var router: (CharacterListRoutingLogic & CharacterListDataPassing)?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let footerView = UIActivityIndicatorView(style: .large)
    var viewModel: CharacterList.FetchCharacters.ViewModel?
    var listType: CharacterList.ListType = .vertical
    
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
        collectionView.addFooter()
        setNavigationBarImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func verticalList(_ sender: Any) {
        self.listType = .vertical
        self.collectionView.reloadData()
    }
    
    @IBAction func gridList(_ sender: Any) {
        self.listType = .grid
        self.collectionView.reloadData()
    }
    
    func setNavigationBarImage() {
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        let imageView = UIImageView(
            frame: CGRect(
                x: (UIScreen.main.bounds.width - 230)/2,
                y: (44 - 28)/2,
                width: 230,
                height: 28)
        )
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "marvel")
        titleView.addSubview(imageView)
        navigationItem.titleView = titleView
    }
}

extension CharacterListViewController: CharacterListDisplayLogic {
    func displayCharacters(viewModel: CharacterList.FetchCharacters.ViewModel) {
        footerView.stopAnimating()
        self.viewModel = viewModel
        collectionView.reloadData()
    }
    
    func displayError(_ message: String) {
        footerView.stopAnimating()
        // TODO error message
    }
}

extension CharacterListViewController: UICollectionViewDelegate,
                                       UICollectionViewDataSource,
                                       UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        
        viewModel?.characters.count ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch self.listType {
        case .vertical:
            let cell = collectionView.dequeueCell(type: VerticalCharacterCell.self, indexPath: indexPath)
            cell.configureCell(with: viewModel?.characters[indexPath.row])
            return cell
        case .grid:
            let cell = collectionView.dequeueCell(type: GridCharacterCell.self, indexPath: indexPath)
            cell.configureCell(with: viewModel?.characters[indexPath.row])
            return cell
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch self.listType {
        case .vertical:
            return CGSize(width: UIScreen.main.bounds.width, height: 140)
        case .grid:
            return CGSize(width: (UIScreen.main.bounds.width - 72) / 2, height: 220)
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        switch self.listType {
        case .grid:
            return 32
        default:
            return 0
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 24
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        switch self.listType {
        case .vertical:
            return UIEdgeInsets(top: 24, left: 0, bottom: 24, right: 0)
        case .grid:
            return UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath) {
        
        if indexPath.row == (viewModel?.characters.count ?? 0) - 3 {
            footerView.startAnimating()
            interactor?.fetchNewCharacters()
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind, withReuseIdentifier: "Footer", for: indexPath
            )
            footer.addSubview(footerView)
            footerView.frame = CGRect(x: 0, y: 0, width: collectionView.bounds.width, height: 50)
            return footer
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.routeToCharacterDetail(index: indexPath.item)
    }
}

extension CharacterListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        interactor?.fetchSearch(request: .init(searchText: searchText))
    }
}
