//
//  CharactersListViewModel.swift
//  PruebaUI
//
//  Created by Cristobal Ramos on 22/4/24.
//

import Foundation
import SwiftUI
import Combine

enum ViewState {
    case success
    case error
    case loading
}

class CharactersListViewModel: ObservableObject {
    private var api: ApiRequest?
    var cancellable = Set<AnyCancellable>()
    @Published var charactersDataList = CharactersDataList(characterList: [], pages: 10)
    @Published var state: ViewState = .loading
    @Published var searchText: String = ""

    init(api: ApiRequest) {
        self.api = api
    }
    
    func loadCharacterList(page: Int) {
        state = .loading
        api?.fetchCharacterList(page)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure:
                    DispatchQueue.main.async {
                        self.state = .error
                    }
                case .finished:
                    break
                }
            }, receiveValue: { data in
                DispatchQueue.main.async {
                    self.state = .success
                    self.charactersDataList.characterList.append(contentsOf: data.characterList)
                    self.charactersDataList.pages = data.pages
                }
            }).store(in: &cancellable)
    }
    
    var filteredCharacters: [CharacterData] {
        if searchText.isEmpty {
            return charactersDataList.characterList
        } else {
            return charactersDataList.characterList.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}
