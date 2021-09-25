//
//  CharacterDetailViewControllerTests.swift
//  MarvelTests
//
//  Created by Ali Hasanoğlu on 25.09.2021.
//

@testable import Marvel
import XCTest

class CharacterDetailViewControllerTests: XCTestCase {

    var viewController: CharacterDetailViewController?
    let interactor = CharacterDetailInteractor(worker: CharacterDetailWorker())
    var viewModel: CharacterDetail.FetchDetail.ViewModel?
    
    override func setUp() {
        
        guard let viewController = UIStoryboard(
            name: "CharacterDetail", bundle: .main
        ).instantiateViewController(identifier: "CharacterDetailViewController") as?
                CharacterDetailViewController else {
            XCTAssert(false, "View Controller not initialized")
            return
        }
        viewModel = .init(
            id: 123,
            name: "Ali",
            image: "",
            comics: ["comics 1"],
            events: ["events 1", "events 2"],
            stories: ["stories 1", "stories 2", "stories 3"],
            series: ["series 1", "series 2", "series 3", "series 4"]
        )
        self.viewController = viewController
        let presenter = CharacterDetailPresenter()
        presenter.viewController = viewController
        interactor.presenter = presenter
        viewController.interactor = interactor
        viewController.loadView()
        
    }
    
    func testInstances() {
        XCTAssertNotNil(viewController)
        XCTAssertNotNil(viewController?.tableView)
    }
    
    func testTableView() {
        viewController?.viewModel = self.viewModel
        viewController?.tableView.reloadData()
        XCTAssertEqual(viewController?.tableView.numberOfSections, CharacterDetail.Sections.allCases.count)
        for index in 0...CharacterDetail.Sections.allCases.count - 1 {
            XCTAssertEqual(viewController?.tableView.numberOfRows(inSection: index), 1)
        }
    }
    
    func testTableViewCells() {
        viewController?.viewModel = self.viewModel
        viewController?.viewDidLoad()
        viewController?.tableView.reloadData()
        let cell1 = viewController?.tableView.cellForRow(
            at: IndexPath(row: 0, section: 0)) as? CharacterPosterCell
        let cell2 = viewController?.tableView.cellForRow(
            at: IndexPath(row: 0, section: 1)) as? ButtonsCell
        let cell3 = viewController?.tableView.cellForRow(
            at: IndexPath(row: 0, section: 2)) as? CharacterInformationCell
        let cell4 = viewController?.tableView.cellForRow(
            at: IndexPath(row: 0, section: 3)) as? CharacterInformationCell
        let cell5 = viewController?.tableView.cellForRow(
            at: IndexPath(row: 0, section: 4)) as? CharacterInformationCell
        let cell6 = viewController?.tableView.cellForRow(
            at: IndexPath(row: 0, section: 5)) as? CharacterInformationCell
        
        
        
        XCTAssertNotNil(cell1)
        XCTAssertNotNil(cell2)
        XCTAssertNotNil(cell3)
        XCTAssertEqual(cell3?.labelTitle.text, "Comics")
        XCTAssertNotNil(cell4)
        XCTAssertEqual(cell4?.labelTitle.text, "Events")
        XCTAssertNotNil(cell5)
        XCTAssertEqual(cell5?.labelTitle.text, "Stories")
        XCTAssertNotNil(cell6)
        XCTAssertEqual(cell6?.labelTitle.text, "Series")
    }
    
    func testFavorite() {
        interactor.character = nil
        if UserDefaultsHelper.Favorites.contains(0) {
            interactor.handleFavorite()
            XCTAssertFalse(UserDefaultsHelper.Favorites.contains(0))
            interactor.handleFavorite()
            XCTAssertTrue(UserDefaultsHelper.Favorites.contains(0))
        } else {
            interactor.handleFavorite()
            XCTAssertTrue(UserDefaultsHelper.Favorites.contains(0))
            interactor.handleFavorite()
            XCTAssertFalse(UserDefaultsHelper.Favorites.contains(0))
        }
    }
    
    func testSave() {
        
        if UserDefaultsHelper.Character.isCharacterSaved("0") {
            UserDefaults.standard.removeObject(forKey: "0")
            interactor.saveCharacter()
            XCTAssertTrue(UserDefaultsHelper.Character.isCharacterSaved("0"))
        }
        interactor.saveCharacter()
        XCTAssertTrue(UserDefaultsHelper.Character.isCharacterSaved("0"))
    }
}
