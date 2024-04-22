//
//  CharactersListViewModel.swift
//  PruebaUI
//
//  Created by Cristobal Ramos on 22/4/24.
//

import Foundation
import SwiftUI
import Combine

class CharactersListViewModel: ObservableObject {
    private var api: ApiRequest?
    //let showCharactersPublisher = PassthroughSubject<CharactersDataList, Never>()
    let goToCharacterDetailPublisher = PassthroughSubject<CharacterData, Never>()
    let showErrorPublisher = PassthroughSubject<Void, Never>()
    let setTotalCharactersPublisher = PassthroughSubject<Int, Never>()
    var cancellable = Set<AnyCancellable>()
    @Published var charactersDataList: CharactersDataList?
    
    init(api: ApiRequest) {
        self.api = api
    }
    
    func loadCharacterList(page: Int, characterList: [CharacterData]) {
        var list = characterList
        api?.fetchCharacterList(page)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure:
                    self.showErrorPublisher.send()
                case .finished:
                    break
                }
            }, receiveValue: { data in
                list += data.characterList
                self.charactersDataList = CharactersDataList(characterList: list, pages: data.pages)
            }).store(in: &cancellable)
    }
}
