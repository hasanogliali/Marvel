//
//  CharacterListViewControllerTest.swift
//  MarvelTests
//
//  Created by Ali Hasanoğlu on 25.09.2021.
//

@testable import Marvel
@testable import API
import XCTest

class CharacterListViewControllerTest: XCTestCase {

    var viewController: CharacterListViewController?
    var interactor: CharacterListInteractor?
    var viewModel: CharacterList.FetchCharacters.ViewModel?
    var displayLogic = CharacterListDisplayLogicSpy()
    var router = CharacterListRoutingLogicSpy()
    
    override func setUp() {
        
        guard let viewController = UIStoryboard(
            name: "CharacterList", bundle: .main
        ).instantiateViewController(identifier: "CharacterListViewController") as?
        CharacterListViewController else {
            XCTAssert(false, "View Controller not initialized")
            return
        }
        
        self.viewController = viewController
        interactor =  CharacterListInteractor(worker: CharacterListWorkingLogicSpy())
        let presenter = CharacterListPresenter()
        presenter.viewController = displayLogic
        interactor?.presenter = presenter
        viewController.interactor = interactor
        
        viewModel = .init(
            characters:
                [
                    .init(image: "", name: "Atom Karınca", seriesCount: "played 3", id: 123)
                ],
            isSearchActive: false
        )
        
        viewController.router = router
        viewController.loadView()
        viewController.viewDidLoad()
    }

    func testInstances() {
        XCTAssertNotNil(viewController)
        XCTAssertNotNil(viewController?.collectionView)
    }
    
    func testCollectionView() {
        viewController?.viewModel = self.viewModel
        viewController?.collectionView.reloadData()
        XCTAssertEqual(viewController?.collectionView.numberOfSections, 1)
        XCTAssertEqual(viewController?.collectionView.numberOfItems(inSection: 0), 1)
    }
    
    func testTCollectionViewCells() {
        viewController?.viewModel = self.viewModel
        viewController?.collectionView.reloadData()

        guard let collectionView = viewController?.collectionView else {
            XCTAssert(false, "collectionView not initialized.")
            return
        }
        
        let cell1 = collectionView.dataSource?.collectionView(
            collectionView, cellForItemAt: IndexPath(item: 0, section: 0)) as? VerticalCharacterCell
        
        XCTAssertNotNil(cell1)
        XCTAssertEqual(cell1?.labelName.text, "Atom Karınca")
        XCTAssertEqual(cell1?.labelSeriesCount.text, "played 3")
        
        viewController?.listType = .grid
        viewController?.collectionView.reloadData()
        
        let cell2 = collectionView.dataSource?.collectionView(
            collectionView, cellForItemAt: IndexPath(item: 0, section: 0)) as?  GridCharacterCell
        
        XCTAssertNotNil(cell2)
        XCTAssertEqual(cell2?.labelName.text, "Atom Karınca")
        XCTAssertEqual(cell2?.labelSeriesCount.text, "played 3")
    }
    
    func testSearch() {
        interactor?.fetchSearch(request: .init(searchText: ""))
        XCTAssertEqual(interactor?.isSearchActive, false)
        interactor?.fetchSearch(request: .init(searchText: "fd"))
        XCTAssertEqual(interactor?.isSearchActive, true)
    }
    
    func testCharacterSelection() {
        interactor?.characterSelected(request: .init(index: 2))
        XCTAssertEqual(interactor?.selectedCharacterIndex, 2)
        XCTAssertTrue(displayLogic.characterSelectionCalled)
    }
    
    func testRouting() {
        router.routeToCharacterDetail()
        XCTAssertTrue(router.routeToCharacterDetailCalled)
    }
}
