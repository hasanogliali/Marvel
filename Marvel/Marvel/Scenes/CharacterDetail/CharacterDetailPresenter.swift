//
//  CharacterDetailPresenter.swift
//  Marvel
//
//  Created by Ali Hasanoğlu on 22.09.2021.
//

import Foundation
import API

protocol CharacterDetailPresentationLogic: AnyObject {
    func presentCharacterDetail(response: CharacterDetail.FetchDetail.Response)
    func presentFavorite()
    func presentSaveCharacter(response: CharacterDetail.FetchCharacterSave.Response)
}

final class CharacterDetailPresenter: CharacterDetailPresentationLogic {
    
    weak var viewController: CharacterDetailDisplayLogic?
    
    func presentCharacterDetail(response: CharacterDetail.FetchDetail.Response) {
        var comics = [String]()
        var events = [String]()
        var stories = [String]()
        var series = [String]()
        
        response.character?.comics?.items?.forEach{
            comics.append($0.name ?? "")
        }
        
        response.character?.events?.items?.forEach{
            events.append($0.name ?? "")
        }
        
        response.character?.stories?.items?.forEach{
            stories.append($0.name ?? "")
        }
        
        response.character?.series?.items?.forEach{
            series.append($0.name ?? "")
        }
        viewController?.displayCharacterDetail(
            viewModel: .init(
                id: response.character?.id ?? 0,
                name: response.character?.name ?? "",
                image: "\(response.character?.thumbnail?.path ?? "").\(response.character?.thumbnail?.thumbnailExtension ?? "")",
                comics: comics,
                events: events,
                stories: stories,
                series: series
            )
        )
    }
    
    func presentFavorite() {
        viewController?.displayFavorite()
    }
    
    func presentSaveCharacter(response: CharacterDetail.FetchCharacterSave.Response) {
        if response.existBefore {
            viewController?.displaySaveCharacter(viewModel: .init(title: "Warning", message: "Character already saved"))
        }
        let message = response.saved ? "Character saved succesfully": "An error occured while saving character"
        let title = response.saved ? "Success": "Error"
        viewController?.displaySaveCharacter(viewModel: .init(title: title, message: message))
    }
}
